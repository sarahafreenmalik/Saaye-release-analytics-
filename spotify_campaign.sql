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
('2026-10-08', 308,   97, NULL),
('2026-10-12', 369, 146, 144);

-- Spotify playlist sources (Spotify for Artists > "Your top playlists")
CREATE TABLE playlist_streams (
    snapshot_date  DATE,
    playlist       VARCHAR(60),
    playlist_kind  VARCHAR(20),     -- algorithmic, editorial, user, curator
    window_days    INT,             -- reporting window shown by Spotify
    streams        INT
);

INSERT INTO playlist_streams VALUES
('2026-10-12', 'Release Radar', 'algorithmic', 7, 28);

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

-- Q3. Pitch success rate by target type and channel
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

-- Q4. Geographic concentration (share of streams by country)
SELECT
    country,
    streams,
    ROUND(streams / SUM(streams) OVER () * 100, 1) AS pct_of_streams
FROM listener_geo
ORDER BY streams DESC;

-- ---------------------------------------------------------------------
-- Spotify audience, last 28 days to 12 Oct (Spotify for Artists > Audience)
-- ---------------------------------------------------------------------
CREATE TABLE spotify_audience_country (
    snapshot_date DATE, window_days INT, country VARCHAR(40), listeners INT
);
INSERT INTO spotify_audience_country VALUES
('2026-10-12',28,'Pakistan',81),('2026-10-12',28,'United States',30),
('2026-10-12',28,'United Kingdom',11),('2026-10-12',28,'United Arab Emirates',7),
('2026-10-12',28,'Canada',5);

CREATE TABLE spotify_audience_city (
    snapshot_date DATE, window_days INT, city VARCHAR(40), country VARCHAR(40), listeners INT
);
INSERT INTO spotify_audience_city VALUES
('2026-10-12',28,'Islamabad','Pakistan',36),('2026-10-12',28,'Karachi','Pakistan',19),
('2026-10-12',28,'Lahore','Pakistan',18),('2026-10-12',28,'Brooklyn','United States',8),
('2026-10-12',28,'Rawalpindi','Pakistan',8);

CREATE TABLE spotify_audience_age (
    snapshot_date DATE, window_days INT, age_band VARCHAR(10), pct DECIMAL(4,1)
);
INSERT INTO spotify_audience_age VALUES
('2026-10-12',28,'<18',1),('2026-10-12',28,'18-24',9),('2026-10-12',28,'25-34',42),
('2026-10-12',28,'35-44',29),('2026-10-12',28,'45-54',7),('2026-10-12',28,'55-64',4),
('2026-10-12',28,'65+',8);

-- A1. Where listeners are: share of listeners by country
SELECT country, listeners,
       ROUND(listeners / SUM(listeners) OVER () * 100, 1) AS pct_of_top5
FROM spotify_audience_country
ORDER BY listeners DESC;

-- Spotify stream sources and listener profile, last 28 days to 12 Oct
-- (Spotify for Artists > Audience). Sub-rows are shown as Spotify reports them;
-- they don't always add up to their group total because of rounding.
CREATE TABLE spotify_stream_sources (
    snapshot_date DATE, window_days INT,
    source_group  VARCHAR(20),   -- active, programmed, other
    source        VARCHAR(60),
    pct           DECIMAL(4,1)
);
INSERT INTO spotify_stream_sources VALUES
('2026-10-12',28,'active','All active sources',79),
('2026-10-12',28,'active','Artist profile and catalog',75),
('2026-10-12',28,'active','Listener''s own playlists and library',8),
('2026-10-12',28,'active','Listener''s queue',1),
('2026-10-12',28,'programmed','All programmed sources',21),
('2026-10-12',28,'programmed','Editorial playlists',0),
('2026-10-12',28,'programmed','Personalized playlists, autoplay and mixes',21),
('2026-10-12',28,'programmed','Other listeners'' playlists',0),
('2026-10-12',28,'other','Other',1);

CREATE TABLE spotify_audience_gender (
    snapshot_date DATE, window_days INT, gender VARCHAR(20), pct DECIMAL(4,1)
);
INSERT INTO spotify_audience_gender VALUES
('2026-10-12',28,'Female',55),('2026-10-12',28,'Male',41),
('2026-10-12',28,'Non-binary',0),('2026-10-12',28,'Not specified',4);

CREATE TABLE spotify_listener_stats (
    snapshot_date DATE, window_days INT,
    streams_per_listener      DECIMAL(3,1),
    pct_streams_from_active_listeners DECIMAL(4,1)
);
INSERT INTO spotify_listener_stats VALUES ('2026-10-12',28,3.2,93);

-- A3. How people found the song: active (they went looking) vs programmed (Spotify served it)
SELECT source_group, source, pct
FROM spotify_stream_sources
WHERE source NOT LIKE 'All %'
ORDER BY pct DESC;

-- Spotify for Artists home, 12 Oct: last-7-day totals and top songs
CREATE TABLE spotify_release_week (
    snapshot_date DATE, window_days INT, release VARCHAR(40),
    listeners INT, streams INT, followers INT
);
INSERT INTO spotify_release_week VALUES ('2026-10-12',7,'Saaye',83,206,144);

CREATE TABLE spotify_top_songs (
    snapshot_date DATE, window_days INT, song VARCHAR(40), streams INT
);
INSERT INTO spotify_top_songs VALUES
('2026-10-12',7,'Saaye',186),('2026-10-12',7,'Aag',14),('2026-10-12',7,'Khamoshi',3);

-- A5. Catalogue lift: did the new single send listeners to older songs?
SELECT song, streams,
       ROUND(streams / SUM(streams) OVER () * 100, 1) AS pct_of_top_songs
FROM spotify_top_songs
ORDER BY streams DESC;

-- P2. Pitch success by channel (personal outreach vs. submission platforms)
SELECT channel,
       COUNT(*)                     AS pitched,
       SUM(outcome = 'accepted')    AS accepted,
       SUM(outcome = 'declined')    AS declined,
       SUM(outcome = 'pending')     AS no_response_yet,
       ROUND(SUM(outcome = 'accepted') / COUNT(*) * 100, 0) AS acceptance_pct
FROM pitches
GROUP BY channel
ORDER BY acceptance_pct DESC;

-- D1. Data completeness: which campaign days have no Spotify snapshot?
-- A recursive CTE builds every date from release day to 12 Oct, then LEFT JOINs the snapshots.
WITH RECURSIVE days AS (
    SELECT DATE('2026-10-02') AS day
    UNION ALL
    SELECT day + INTERVAL 1 DAY FROM days WHERE day < '2026-10-12'
)
SELECT d.day,
       s.all_time_streams,
       s.monthly_listeners,
       CASE WHEN s.snapshot_date IS NULL THEN 'no snapshot'
            WHEN s.all_time_streams IS NULL THEN 'streams missing'
            WHEN s.monthly_listeners IS NULL THEN 'listeners missing'
            ELSE 'complete' END AS status
FROM days d
LEFT JOIN spotify_daily s ON s.snapshot_date = d.day
ORDER BY d.day;
