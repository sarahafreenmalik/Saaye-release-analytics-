# Saaye: What Grew My Audience?
### SQL analysis of an independent single release

I released my single **"Saaye"** independently on 2 October 2026 and ran the whole campaign myself. I then modelled the Instagram and Spotify data in MySQL to find out which content actually grew my audience.

**Headline:** 5 reels reached ~13,100 people who didn't follow me and produced **all 12 new follows**. 42 stories produced none, but they drove the reshares that fed the reels.

**[View the interactive dashboard](https://claude.ai/artifact/SnEMVQHP4WQ3UXrZDcLpE3)**

<!-- Add dashboard screenshot here: ![Dashboard](images/dashboard.png) -->

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

**4. Designed call-to-action stories work better.** Designed Spotify cards got 5–6.5% interaction vs 1–2% for bare links.

**5. Streaming followed.** Spotify streams grew from 109 on release day to 308 by day 7; monthly listeners went from 9 to 97. Both radio pitches and one playlist pitch were accepted.

## What I'll do next release

- Lead with performance reels: face and voice in the first second.
- Line up reshare partners before posting lyric reels.
- Keep the story highlight under ~20 stories, best content first.
- No bare links: designed cards for every call-to-action.
- Log insights daily from day one instead of reconstructing them afterwards.

## Limitations

One release, five reels: the patterns are directional, not proven. Three stories (pre-save, countdown, release day) reached far more non-followers than the rest and may have been boosted; this is being confirmed.

## Repo contents

```
sql/instagram_insights.sql   schema, data and analysis queries for Instagram
sql/spotify_campaign.sql     schema, data and analysis queries for Spotify + pitching
data/                        query results as CSV
images/                      dashboard screenshots
```

To run: open either SQL file in MySQL Workbench and execute it top to bottom.

---

**Sarah Afreen Malik** · Data analyst, UX designer and independent artist
[LinkedIn](https://www.linkedin.com/in/sarah-malik-38113378) · [GitHub](https://github.com/sarahafreenmalik) · [Instagram](https://instagram.com/sarahafreenmalik)
