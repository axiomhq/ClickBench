['clickbench-hits'] | summarize count()
['clickbench-hits'] | where AdvEngineID != 0 | summarize count()
['clickbench-hits'] | summarize sum(AdvEngineID), count(), avg(ResolutionWidth)
['clickbench-hits'] | extend userID = toint(UserID) | summarize avg(userID)
['clickbench-hits'] | extend userID = toint(UserID) | summarize dcount(userID)
['clickbench-hits'] | summarize dcount(SearchPhrase)
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | summarize min(eventDate), max(eventDate)
['clickbench-hits'] | where AdvEngineID != 0 | summarize Count = count() by AdvEngineID | order by Count desc
['clickbench-hits'] | extend userID = toint(UserID) | summarize u = dcount(userID) by RegionID | order by u desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | summarize SumAdvEngineID = sum(AdvEngineID), c = count(), AvgResolutionWidth = avg(ResolutionWidth), CountDistinctUserID = dcount(userID) by RegionID | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | where MobilePhoneModel != "" | summarize u = dcount(userID) by MobilePhoneModel | order by u desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | where MobilePhoneModel != "" | summarize u = dcount(userID) by MobilePhone, MobilePhoneModel | order by u desc | take 10
['clickbench-hits'] | where SearchPhrase != "" | summarize c = count() by SearchPhrase | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | where SearchPhrase != "" | summarize u = dcount(userID) by SearchPhrase | order by u desc | take 10
['clickbench-hits'] | where SearchPhrase != "" | summarize c = count() by SearchEngineID, SearchPhrase | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | summarize c = count() by userID | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | summarize c = count() by userID, SearchPhrase | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | summarize c = count() by userID, SearchPhrase | take 10
['clickbench-hits'] | extend m = datetime_part("Minute", _time), userID = toint(UserID) | summarize c = count() by userID, m, SearchPhrase | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | where userID == 435090932899640449 | project userID
['clickbench-hits'] | where URL contains "google" | summarize Count = count()
['clickbench-hits'] | where URL contains "google" and SearchPhrase != "" | summarize c = count(), MinURL = min(URL) by SearchPhrase | order by c desc | take 10
['clickbench-hits'] | extend userID = toint(UserID) | where Title contains "Google" and URL !contains ".google." and SearchPhrase != "" | summarize c = count(), MinURL = min(URL), MinTitle = min(Title), CountDistinctUserID = dcount(userID) by SearchPhrase | order by c desc | take 10
['clickbench-hits'] | where URL contains "google" | project * | order by _time | take 10
['clickbench-hits'] | where SearchPhrase != "" | project SearchPhrase | order by _time | take 10
['clickbench-hits'] | where SearchPhrase != "" | project SearchPhrase | order by SearchPhrase | take 10
['clickbench-hits'] | where SearchPhrase != "" | project SearchPhrase | order by _time, SearchPhrase | take 10
['clickbench-hits'] | where URL != "" | summarize c = count(), l = avg(strlen(URL)) by CounterID | where c > 100000 | order by l desc | take 25
['clickbench-hits'] | where Referer != "" | extend k = extract(@"^https?://(?:www\.)?([^/]+)/.*$", 1, Referer) | summarize l = avg(strlen(Referer)), c = count(), MinReferer = min(Referer) by k | where c > 100000 | order by l desc | take 25
['clickbench-hits'] | summarize sum0 = sum(ResolutionWidth), sum1 = sum(ResolutionWidth + 1), sum2 = sum(ResolutionWidth + 2), sum3 = sum(ResolutionWidth + 3), sum4 = sum(ResolutionWidth + 4), sum5 = sum(ResolutionWidth + 5), sum6 = sum(ResolutionWidth + 6), sum7 = sum(ResolutionWidth + 7), sum8 = sum(ResolutionWidth + 8), sum9 = sum(ResolutionWidth + 9), sum10 = sum(ResolutionWidth + 10), sum11 = sum(ResolutionWidth + 11), sum12 = sum(ResolutionWidth + 12), sum13 = sum(ResolutionWidth + 13), sum14 = sum(ResolutionWidth + 14), sum15 = sum(ResolutionWidth + 15), sum16 = sum(ResolutionWidth + 16), sum17 = sum(ResolutionWidth + 17), sum18 = sum(ResolutionWidth + 18), sum19 = sum(ResolutionWidth + 19), sum20 = sum(ResolutionWidth + 20), sum21 = sum(ResolutionWidth + 21), sum22 = sum(ResolutionWidth + 22), sum23 = sum(ResolutionWidth + 23), sum24 = sum(ResolutionWidth + 24), sum25 = sum(ResolutionWidth + 25), sum26 = sum(ResolutionWidth + 26), sum27 = sum(ResolutionWidth + 27), sum28 = sum(ResolutionWidth + 28), sum29 = sum(ResolutionWidth + 29), sum30 = sum(ResolutionWidth + 30), sum31 = sum(ResolutionWidth + 31), sum32 = sum(ResolutionWidth + 32), sum33 = sum(ResolutionWidth + 33), sum34 = sum(ResolutionWidth + 34), sum35 = sum(ResolutionWidth + 35), sum36 = sum(ResolutionWidth + 36), sum37 = sum(ResolutionWidth + 37), sum38 = sum(ResolutionWidth + 38), sum39 = sum(ResolutionWidth + 39), sum40 = sum(ResolutionWidth + 40), sum41 = sum(ResolutionWidth + 41), sum42 = sum(ResolutionWidth + 42), sum43 = sum(ResolutionWidth + 43), sum44 = sum(ResolutionWidth + 44), sum45 = sum(ResolutionWidth + 45), sum46 = sum(ResolutionWidth + 46), sum47 = sum(ResolutionWidth + 47), sum48 = sum(ResolutionWidth + 48), sum49 = sum(ResolutionWidth + 49), sum50 = sum(ResolutionWidth + 50), sum51 = sum(ResolutionWidth + 51), sum52 = sum(ResolutionWidth + 52), sum53 = sum(ResolutionWidth + 53), sum54 = sum(ResolutionWidth + 54), sum55 = sum(ResolutionWidth + 55), sum56 = sum(ResolutionWidth + 56), sum57 = sum(ResolutionWidth + 57), sum58 = sum(ResolutionWidth + 58), sum59 = sum(ResolutionWidth + 59), sum60 = sum(ResolutionWidth + 60), sum61 = sum(ResolutionWidth + 61), sum62 = sum(ResolutionWidth + 62), sum63 = sum(ResolutionWidth + 63), sum64 = sum(ResolutionWidth + 64), sum65 = sum(ResolutionWidth + 65), sum66 = sum(ResolutionWidth + 66), sum67 = sum(ResolutionWidth + 67), sum68 = sum(ResolutionWidth + 68), sum69 = sum(ResolutionWidth + 69), sum70 = sum(ResolutionWidth + 70), sum71 = sum(ResolutionWidth + 71), sum72 = sum(ResolutionWidth + 72), sum73 = sum(ResolutionWidth + 73), sum74 = sum(ResolutionWidth + 74), sum75 = sum(ResolutionWidth + 75), sum76 = sum(ResolutionWidth + 76), sum77 = sum(ResolutionWidth + 77), sum78 = sum(ResolutionWidth + 78), sum79 = sum(ResolutionWidth + 79), sum80 = sum(ResolutionWidth + 80), sum81 = sum(ResolutionWidth + 81), sum82 = sum(ResolutionWidth + 82), sum83 = sum(ResolutionWidth + 83), sum84 = sum(ResolutionWidth + 84), sum85 = sum(ResolutionWidth + 85), sum86 = sum(ResolutionWidth + 86), sum87 = sum(ResolutionWidth + 87), sum88 = sum(ResolutionWidth + 88), sum89 = sum(ResolutionWidth + 89)
['clickbench-hits'] | where SearchPhrase != '' | summarize c=count(), SumIsRefresh=sum(IsRefresh), AvgResolutionWidth=avg(ResolutionWidth) by SearchEngineID, ClientIP | order by c desc | take 10
['clickbench-hits'] | where SearchPhrase != '' | summarize c=count(), SumIsRefresh=sum(IsRefresh), AvgResolutionWidth=avg(ResolutionWidth) by WatchID, ClientIP | order by c desc | take 10
['clickbench-hits'] | summarize c=count(), SumIsRefresh=sum(IsRefresh), AvgResolutionWidth=avg(ResolutionWidth) by WatchID, ClientIP | order by c desc | take 10
['clickbench-hits'] | summarize c=count() by URL | order by c desc | take 10
['clickbench-hits'] | summarize c=count() by URL | extend DummyColumn=1 | order by c desc | take 10
['clickbench-hits'] | extend ClientIP_1=ClientIP - 1, ClientIP_2=ClientIP - 2, ClientIP_3=ClientIP - 3 | summarize c=count() by ClientIP, ClientIP_1, ClientIP_2, ClientIP_3 | order by c desc | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-01') and eventDate <= datetime('2013-07-31') and DontCountHits == 0 and IsRefresh == 0 and URL != '' | summarize PageViews=count() by URL | order by PageViews desc | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-01') and eventDate <= datetime('2013-07-31') and DontCountHits == 0 and IsRefresh == 0 and Title != '' | summarize PageViews=count() by Title | order by PageViews desc | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-01') and eventDate <= datetime('2013-07-31') and IsRefresh == 0 and IsLink != 0 and IsDownload == 0 | summarize PageViews=count() by URL | order by PageViews desc | skip 1000 | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-01') and eventDate <= datetime('2013-07-31') and IsRefresh == 0 | extend Src = iif(SearchEngineID == 0 and AdvEngineID == 0, Referer, '') | extend Dst = URL | summarize PageViews=count() by TraficSourceID, SearchEngineID, AdvEngineID, Src, Dst | order by PageViews desc | skip 1000 | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-01') and eventDate <= datetime('2013-07-31') and IsRefresh == 0 and TraficSourceID in (-1, 6) and RefererHash == 3594120000172545465 | summarize PageViews=count() by URLHash, eventDate | order by PageViews desc | skip 100 | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-01') and eventDate <= datetime('2013-07-31') and IsRefresh == 0 and DontCountHits == 0 and URLHash == 2868770270353813622 | summarize PageViews=count() by WindowClientWidth, WindowClientHeight | order by PageViews desc | skip 10000 | take 10
['clickbench-hits'] | extend eventDate = todatetime(EventDate) | where CounterID == 62 and eventDate >= datetime('2013-07-14') and eventDate <= datetime('2013-07-15') and IsRefresh == 0 and DontCountHits == 0 | summarize PageViews=count() by M=bin(_time, 1m) | order by M | skip 1000 | take 10