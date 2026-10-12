-- =====================================================================
-- SAAYE RELEASE CAMPAIGN — SQL ANALYSIS (MySQL 8+)
-- Organic, zero-ad-spend, 7-day solo campaign | Release: 2 Oct 2026
-- =====================================================================

CREATE DATABASE IF NOT EXISTS saaye_campaign;
USE saaye_campaign;

-- ---------------------------------------------------------------------
-- 1. TABLES
-- ---------------------------------------------------------------------

-- Daily Spotify for Artists snapshot (one row per day)
CREATE TABLE spotify_daily (
    snapshot_date      DATE PRIMARY KEY,
    all_time_streams   INT,
    monthly_listeners  INT,
    followers          INT
);

-- Every piece of content posted (yours + creator collabs)
CREATE TABLE content_posts (
    post_id       INT AUTO_INCREMENT PRIMARY KEY,
    post_date     DATE,
    platform      VARCHAR(30),   -- Instagram, TikTok, YouTube, SoundCloud...
    post_type     VARCHAR(30),   -- lyrical_reel, making_of, creator_collab, story
    made_by       VARCHAR(20),   -- 'own' or 'creator'
    creator_name  VARCHAR(60),
    hook_version  CHAR(1),       -- 'A' original / 'B' shortened hook (A/B test)
    views         INT,
    likes         INT,
    comments      INT,
    shares        INT,
    saves         INT,
    follows       INT
);

-- Every pitch / outreach
CREATE TABLE pitches (
    pitch_id     INT AUTO_INCREMENT PRIMARY KEY,
    pitch_date   DATE,
    target_name  VARCHAR(60),
    target_type  VARCHAR(20),    -- playlist, blog, radio, editorial
    channel      VARCHAR(30),    -- SubmitHub, email, DM, warm_intro
    outcome      VARCHAR(20)     -- accepted, declined, pending
);

-- Listener geography (Spotify for Artists, 28-day window to 2 Oct)
CREATE TABLE listener_geo (
    country  VARCHAR(30),
    streams  INT
);

-- ---------------------------------------------------------------------
-- 2. DATA (from your logged screenshots — fill gaps as you go)
-- ---------------------------------------------------------------------

INSERT INTO spotify_daily VALUES
('2026-10-02', 109, NULL, 131),
('2026-10-03', 181, NULL, 134),
('2026-10-04', 194,   52, NULL),
('2026-10-05', NULL,  76, NULL),
('2026-10-06', NULL,  86, NULL),
('2026-10-08', 308,   97, NULL);

INSERT INTO pitches (pitch_date, target_name, target_type, channel, outcome) VALUES
('2026-10-01', 'Horizon Harmonics', 'playlist', 'SubmitHub', 'pending'),
('2026-10-01', 'Neon Music',        'blog',     'SubmitHub', 'declined'),
('2026-10-02', 'Somo',              'playlist', 'DM',        'accepted'),
('2026-10-02', 'Greesha',           'playlist', 'DM',        'declined'),
('2026-10-02', 'Parisha',           'playlist', 'DM',        'pending'),
('2026-10-03', 'Rudo (Apple Music)','editorial','DM',        'pending'),
('2026-10-01', 'CityFM89 (Sabah)',  'radio',    'warm_intro','accepted'),
('2026-10-01', 'CityFM91',          'radio',    'email',     'accepted');

INSERT INTO listener_geo VALUES
('Pakistan', 93), ('United States', 12), ('United Kingdom', 3),
('UAE', 2), ('Australia', 1);

-- content_posts: paste in from your Instagram Excel export (CSV), e.g.
-- LOAD DATA LOCAL INFILE 'instagram_posts.csv' INTO TABLE content_posts
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 LINES
-- (post_date, platform, post_type, made_by, creator_name, hook_version,
--  views, likes, comments, shares, saves, follows);

-- ---------------------------------------------------------------------
-- 3. ANALYSIS QUERIES
-- ---------------------------------------------------------------------

-- Q1. Daily stream growth + listener growth (window functions)
SELECT
    snapshot_date,
    all_time_streams,
    all_time_streams
      - LAG(all_time_streams) OVER (ORDER BY snapshot_date) AS new_streams,
    monthly_listeners,
    monthly_listeners
      - LAG(monthly_listeners) OVER (ORDER BY snapshot_date) AS listener_change,
    DATEDIFF(snapshot_date, '2026-10-02') + 1 AS campaign_day
FROM spotify_daily
ORDER BY snapshot_date;

-- Q2. Overall campaign lift: release day vs latest
SELECT
    MIN(all_time_streams) AS day1_streams,
    MAX(all_time_streams) AS latest_streams,
    ROUND((MAX(all_time_streams) - MIN(all_time_streams))
          / MIN(all_time_streams) * 100, 1) AS pct_growth
FROM spotify_daily
WHERE all_time_streams IS NOT NULL;

-- Q3. Own content vs creator content (your "own content resonates more" claim)
SELECT
    made_by,
    COUNT(*)                                   AS posts,
    ROUND(AVG(views), 0)                       AS avg_views,
    ROUND(AVG(saves + shares) / AVG(views) * 100, 2) AS save_share_rate_pct,
    ROUND(SUM(follows) / COUNT(*), 1)          AS follows_per_post
FROM content_posts
GROUP BY made_by;

-- Q4. A/B test: original hook (A) vs shortened hook (B)
SELECT
    hook_version,
    COUNT(*)                                       AS posts,
    ROUND(AVG(views), 0)                           AS avg_views,
    ROUND(SUM(saves)    / SUM(views) * 100, 2)     AS save_rate_pct,
    ROUND(SUM(comments) / SUM(views) * 100, 2)     AS comment_rate_pct,
    ROUND(SUM(follows)  / SUM(views) * 100, 2)     AS follow_rate_pct
FROM content_posts
WHERE hook_version IS NOT NULL
GROUP BY hook_version;

-- Q5. Does a post day move Spotify? (streams gained the day after a post)
WITH daily AS (
    SELECT snapshot_date,
           all_time_streams
             - LAG(all_time_streams) OVER (ORDER BY snapshot_date) AS new_streams
    FROM spotify_daily
    WHERE all_time_streams IS NOT NULL
)
SELECT
    p.post_date, p.post_type, p.made_by, p.views,
    d.new_streams AS streams_next_snapshot
FROM content_posts p
LEFT JOIN daily d
       ON d.snapshot_date = (SELECT MIN(snapshot_date) FROM daily
                             WHERE snapshot_date > p.post_date)
ORDER BY p.post_date;

-- Q6. Pitch success rate by target type and channel
SELECT
    target_type,
    channel,
    COUNT(*)                                            AS pitched,
    SUM(outcome = 'accepted')                           AS accepted,
    SUM(outcome = 'declined')                           AS declined,
    ROUND(SUM(outcome = 'accepted') /
          NULLIF(SUM(outcome <> 'pending'), 0) * 100, 0) AS win_rate_pct
FROM pitches
GROUP BY target_type, channel
ORDER BY win_rate_pct DESC;

-- Q7. Geographic concentration (share of streams by country)
SELECT
    country,
    streams,
    ROUND(streams / SUM(streams) OVER () * 100, 1) AS pct_of_streams
FROM listener_geo
ORDER BY streams DESC;
