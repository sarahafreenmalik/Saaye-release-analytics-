# Saaye: What Grew My Audience?
### SQL analysis of an independent single release

I released my single **"Saaye"** independently on 2 October 2026 and ran the whole campaign myself, fully organically: no paid ads or boosted posts. I then modelled the Instagram and Spotify data in MySQL to find out which content actually grew my audience.

**Headline:** 5 reels reached ~13,100 people who didn't follow me and produced **all 12 new follows**. 46 stories produced none, but they drove the reshares that fed the reels.

**[View the interactive dashboard](https://claude.ai/artifact/SnEMVQHP4WQ3UXrZDcLpE3)**

<!-- Add dashboard screenshot here: ![Saaye dashboard](dashboard.png) -->

---

## The question

With no label, no budget and limited time, which content is worth making for the next release?

1. Which content brings in new people, and which only reaches existing followers?
2. How do people find each reel: through reshares, or Instagram recommending it?
3. Which story formats get people to engage?
4. How did Instagram activity line up with Spotify growth?

## Data

Instagram doesn't export story or reel insights, so I transcribed them from screenshots into MySQL tables.

| Table | Grain | Contents |
|---|---|---|
| `ig_stories` | one row per story | views, interactions, exits, link clicks, non-follower share, format |
| `ig_reels` | one row per reel | views, watch time, skip rate, shares, profile visits, follows |
| `ig_reel_sources` | reel × source | share of views from Stories, Feed, Reels tab, Explore, Search, Profile |
| `ig_reel_age` | reel × age band | audience age split |
| `spotify_daily` | one row per day | all-time streams, monthly listeners |
| `playlist_streams` | playlist × snapshot | streams from each playlist source |
| `spotify_audience_country` / `_city` / `_age` / `_gender` | one row per country, city, age band or gender | Spotify listeners, last 28 days |
| `spotify_stream_sources` | one row per source | share of streams by source (profile, playlists, algorithm) |
| `spotify_release_week` / `spotify_top_songs` | one row per snapshot or song | last-7-day listeners, streams, followers and top songs |
| `ig_account_summary` | one row per period | account-level views, non-follower share, follower change |
| `pitches` | one row per pitch | target, type, outcome |
| `listener_geo` | one row per country | Spotify streams |

**SQL techniques:** CTEs, window functions, conditional aggregation, derived metrics (new people reached = viewers × non-follower share; recommended share = Reels tab + Explore + Search).

## Findings

**1. Reels grew the audience; stories looked after it.**

| Reel | Views | New people reached | Skip rate | Shares | Follows |
|---|---|---|---|---|---|
| Lyric: "I'm so delusional" | 9,732 | 4,649 | 69% | 56 | 2 |
| Performance: singing on camera | 8,098 | 4,323 | 46% | 333 | 4 |
| Lyric: "tere saaye mein hoon" | 8,877 | 2,893 | 82% | 17 | 5 |
| BTS: Studio Session 1 | 2,122 | 813 | 58% | 5 | 1 |
| CityFM89 radio feature | 1,385 | 468 | 77% | 2 | 0 |

**2. My face and voice beat text and artwork.** The performance reel had the lowest skip rate (46%), 333 shares (6× any other reel) and 298 profile visits.

**3. Different reels spread differently.** Lyric reels got 38–62% of views from story reshares. The performance reel got a third of its views from Instagram recommending it (Reels tab, Explore, Search).

**4. Designed call-to-action stories work better.** Designed Spotify cards got 5–6.5% interaction vs 1–2% for bare links. Sharing progress worked too: my milestone story ("from 9 to 110 monthly listeners in 7 days, completely organic") got 421 views and a 6.9% interaction rate, more than any stream-link story.

**5. Streaming kept growing after the campaign.** Spotify streams grew from 109 on release day to 308 by day 7 and 369 by 12 October (+239%). Monthly listeners went from 9 before release to 97 by day 7 and 146 by 12 October, and Spotify followers rose from 131 to 144. The single also lifted my older songs: in the last 7 days, "Aag" got 14 streams and "Khamoshi" 3. Spotify's algorithm picked the song up: Release Radar, its personalised new-music playlist, was my top playlist source with 28 streams in the 7 days to 12 October. Over the last 28 days, 75% of streams came from people going to my artist page, 21% from Spotify's personalised playlists, autoplay and mixes, and 0% from editorial playlists. Listeners played the song 3.2 times each on average.

**6. Relationships beat submission platforms.** Both pitches that went through a personal connection or direct email (CityFM89, CityFM91) were accepted. Of four direct-message pitches to curators, one was accepted (Somo). The two SubmitHub pitches produced nothing: one declined, one with no response.

| Channel | Pitched | Accepted |
|---|---|---|
| Warm intro / email | 2 | 2 |
| Direct message | 4 | 1 |
| SubmitHub | 2 | 0 |

**7. My Spotify listeners match my Instagram reel audience.** 70% of reel viewers and 71% of Spotify listeners are aged 25–44. Spotify skews slightly older: under-25s were 26% of reel viewers but only 10% of listeners. Listeners came from Pakistan (81), the US (30), the UK (11), the UAE (7) and Canada (5), led by Islamabad, Karachi and Lahore. Gender tells a similar story: my everyday stories reached mostly men (24% women), but the three release-moment stories that broke out to non-followers reached 58% women, and my Spotify listeners are 55% women. That suggests the release-moment reach is where many listeners came from, though Instagram doesn't let me trace individuals.

| Age | Instagram reel viewers | Spotify listeners |
|---|---|---|
| Under 25 | 26% | 10% |
| 25–34 | 50% | 42% |
| 35–44 | 19% | 29% |
| 45+ | 4% | 19% |

## What I'll do next release

- Lead with performance reels: face and voice in the first second.
- Line up reshare partners before posting lyric reels.
- Keep the story highlight under ~20 stories, best content first.
- No bare links: designed cards for every call-to-action.
- Log insights daily from day one instead of reconstructing them afterwards.
- Put pitching time into personal outreach rather than submission platforms.
- Avoid engagement-bait wording ("DM me", "comment below"); use question stickers or "link in bio", and check Instagram's Account Status weekly.

## Limitations

One release, five reels and eight pitches: the patterns are directional, not proven. Three stories (pre-save, countdown, release day) reached far more non-followers than the rest; no posts were boosted, so this was organic, though the exact cause isn't visible in Instagram's data. A post asking people to "DM me now" was flagged by Instagram as engagement bait, which limited recommendations to non-followers for a period, so some reach figures may understate how the content could have performed. At account level, September brought about 98K views with 54% from non-followers; in the 14 days to 11 October, views fell 42% on the previous fortnight and the account lost a net 27 followers. That drop coincides with the flag, though it could also reflect less posting after release.

## Repo contents

```
instagram_insights.sql   schema, data and analysis queries for Instagram
spotify_campaign.sql     schema, data and analysis queries for Spotify + pitching
*.csv                    query results behind each dashboard chart
```

To run: in MySQL Workbench, run spotify_campaign.sql first (it creates the database), then instagram_insights.sql.

---

**Sarah Afreen Malik** · Data analyst, UX designer and independent artist
[LinkedIn](https://www.linkedin.com/in/sarah-malik-38113378) · [GitHub](https://github.com/sarahafreenmalik) · [Instagram](https://instagram.com/sarahafreenmalik)
