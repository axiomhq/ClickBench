package main

import (
	"bufio"
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"sort"
	"time"
)

// serverVersionsCmd enriches incoming events with the server versions found
// in their traces (from trace_id), which we query. This is done separate from
// run so that we can wait for a while until traces have been flushed and propagated, as
// well as to avoid slowing down the run command.
func serverVersionsCmd() command {
	fs := flag.NewFlagSet("server-versions", flag.ExitOnError)

	apiURL := fs.String(
		"api-url",
		firstNonZero(os.Getenv("AXIOM_URL"), "https://api.axiom.co/"),
		"Axiom API base URL [defaults to $AXIOM_URL when set]",
	)
	traceURL := fs.String("trace-url", "", "Axiom trace URL where traceId query argument will be added")
	org := fs.String("org", os.Getenv("AXIOM_ORG_ID"), "Axiom organization [defaults to $AXIOM_ORG_ID]")
	token := fs.String("token", os.Getenv("AXIOM_TOKEN"), "Axiom auth token [defaults to $AXIOM_TOKEN]")
	failfast := fs.Bool("failfast", false, "Exit on first error")
	label := fs.String("label", "", "Profile label")

	return command{fs, func(args []string) error {
		fs.Parse(args)
		return serverVersions(*apiURL, *traceURL, *org, *token, *label, *failfast)
	}}
}

func serverVersions(apiURL, traceURL, org, token, label string, failfast bool) error {
	if apiURL == "" {
		return fmt.Errorf("api-url cannot be empty")
	}

	if token == "" {
		return fmt.Errorf("token cannot be empty")
	}

	cli, err := newAxiomClient(http.DefaultClient, gitSha(), apiURL, org, token, traceURL, label)
	if err != nil {
		return fmt.Errorf("error creating axiom client: %w", err)
	}

	var (
		sc       = bufio.NewScanner(os.Stdin)
		ctx      = context.Background()
		results  []*QueryResult
		traceIDs []string
		earliest time.Time
	)

	sc.Buffer(make([]byte, 0, 10*1024*1024), 0)

	for sc.Scan() {
		var r QueryResult
		if err := json.Unmarshal(sc.Bytes(), &r); err != nil {
			if failfast {
				return err
			}

			log.Printf("error: %v", err)
			continue
		}

		if earliest.IsZero() || r.Time.Before(earliest) {
			earliest = r.Time
		}

		if r.TraceID != "" {
			traceIDs = append(traceIDs, r.TraceID)
			results = append(results, &r)
		}
	}

	if sc.Err() != nil {
		return sc.Err()
	}

	serverVersions, err := cli.ServerVersions(ctx, earliest.Add(-30*time.Second), traceIDs)
	if err != nil {
		return fmt.Errorf("error getting server versions: %w", err)
	}

	var (
		buf bytes.Buffer
		enc = json.NewEncoder(os.Stdout)
	)

	for _, r := range results {
		buf.Reset()

		var (
			versionNames = make(map[string][]string)
			versions     []string
		)

		r.ServerVersions = serverVersions[r.TraceID]
		for name, version := range r.ServerVersions {
			if _, ok := versionNames[version]; !ok {
				versions = append(versions, version)
			}
			versionNames[version] = append(versionNames[version], name)
		}

		sort.Strings(versions)

		for _, version := range versions {
			names := versionNames[version]
			sort.Strings(names)
			fmt.Fprintf(&buf, "%s=%v,", version, names)
		}

		if buf.Len() > 0 {
			buf.Truncate(buf.Len() - 1)
		}

		r.ServerVersion = buf.String()

		if err := enc.Encode(r); err != nil {
			return err
		}
	}

	return nil
}
