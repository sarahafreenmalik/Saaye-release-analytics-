-- =====================================================================
-- SAAYE — INSTAGRAM STORY HIGHLIGHT INSIGHTS (MySQL 8+)
-- Run after saaye_campaign_analysis.sql (same database)
-- =====================================================================
USE saaye_campaign;

CREATE TABLE ig_stories (
    story_id          INT PRIMARY KEY,      -- order in the "Saaye" highlight
    story_label       VARCHAR(60),
    content_type      VARCHAR(20),          -- teaser, bts, cover_reveal, ugc_reply, reshare
    made_by           VARCHAR(20),          -- 'own' or 'reshare'
    reshared_from     VARCHAR(40),
    post_date         DATE,                 -- fill in; only Sabah's is known
    views             INT,
    viewers           INT,                  -- unique accounts (NULL = not captured)
    interactions      INT,
    profile_activity  INT,
    likes             INT,
    replies           INT,
    shares            INT,
    sticker_taps      INT,
    nonfollower_view_pct DECIMAL(4,1),
    taps_forward      INT,
    exits             INT,
    next_story        INT,
    taps_back         INT
);

INSERT INTO ig_stories VALUES
(1,'SAAYE coming soon (teaser 1)','teaser','own',NULL,NULL,
    367,NULL,28,2,NULL,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL),
(2,'Studio session photo','bts','own',NULL,NULL,
    449,379,25,2,NULL,NULL,NULL,NULL,12.0,    NULL,NULL,NULL,NULL),
(3,'SAAYE coming soon (teaser 2)','teaser','own',NULL,NULL,
    406,NULL,27,2,NULL,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL),
(4,'Red SAAYE cover reveal','cover_reveal','own',NULL,NULL,
    381,308,20,2,NULL,NULL,NULL,NULL,11.0,    NULL,NULL,NULL,NULL),
(5,'Reply-to-comment video (humming fan)','ugc_reply','own',NULL,NULL,
    287,NULL,6,2,6,0,NULL,NULL,NULL,          NULL,NULL,NULL,NULL),
(6,'Sabah reshare - Cominggg soooon','reshare','reshare','@sabahbanomalik','2026-09-16',
    257,211,7,0,6,0,1,4,20.2,                 161,23,9,8),
(7,'Yusrani reshare - I love it when girls','reshare','reshare','@_yusrani',NULL,
    249,NULL,9,3,8,1,0,3,NULL,                NULL,NULL,NULL,NULL),
(8,'hhprude reshare - never misses','reshare','reshare','@hhprude',NULL,
    227,NULL,9,1,8,1,0,2,NULL,                147,26,7,10),
(9,'alipirzadax reshare','reshare','reshare','@alipirzadax','2026-09-17',
    202,NULL,2,3,2,0,0,4,NULL,                104,41,8,9),
(10,'abdullagauhar reshare','reshare','reshare','@abdullagauhar',NULL,
    235,191,4,3,NULL,NULL,NULL,NULL,19.1,     NULL,NULL,NULL,NULL),
(11,'Reply-to-comment video (madhashmi: SOOOO HOT)','ugc_reply','own',NULL,NULL,
    296,228,10,3,10,0,0,NULL,25.7,            211,23,11,11),
(12,'Now-playing screenshot (Saaye on iPhone)','stream_proof','own',NULL,NULL,
    275,219,12,1,12,0,0,NULL,22.9,            NULL,NULL,NULL,NULL),
(13,'CityFM89 airplay screenshot (1)','radio','own',NULL,NULL,
    239,204,5,3,NULL,NULL,NULL,NULL,20.5,     NULL,NULL,NULL,NULL),
(14,'CityFM89 screenshot + Sabah comment','radio','own',NULL,NULL,
    192,NULL,6,1,6,0,0,NULL,NULL,             NULL,NULL,NULL,NULL),
(15,'Reply-to-comment video (abrarulhasan: Great composition)','ugc_reply','own',NULL,NULL,
    395,NULL,8,1,NULL,NULL,NULL,NULL,NULL,    NULL,NULL,NULL,NULL),
(16,'CityFM89 airplay screenshot (2)','radio','own',NULL,NULL,
    615,468,13,6,NULL,NULL,NULL,NULL,61.6,    NULL,NULL,NULL,NULL),
(17,'Reply-to-comment video (usamakhilji: You''re my addiction)','ugc_reply','own',NULL,NULL,
    226,185,7,1,7,0,0,NULL,12.8,              144,32,19,6),
(18,'hassamanwar reshare (CityFM89)','reshare','reshare','@hassamanwar',NULL,
    210,NULL,4,0,4,0,0,NULL,NULL,             123,35,13,11),
(19,'Reply-to-comment video (madhashmi: Drop the EP)','ugc_reply','own',NULL,NULL,
    259,NULL,10,0,10,0,0,NULL,NULL,           171,32,11,20),
(20,'Spotify pre-save link story (cover art)','presave_cta','own',NULL,NULL,
    4312,3206,70,3,51,9,10,NULL,76.6,         221,67,34,0),
(21,'sabahbanomalik reshare of pre-save','reshare','reshare','@sabahbanomalik',NULL,
    308,NULL,8,0,6,1,1,NULL,NULL,             185,49,12,28),
(22,'ourtarz reshare of pre-save','reshare','reshare','@ourtarz',NULL,
    250,202,9,1,8,1,0,5,16.8,                 144,38,14,18),
(23,'aleem.arif reshare of pre-save','reshare','reshare','@aleem.arif',NULL,
    210,172,3,1,3,0,0,NULL,17.6,              138,25,17,8),
(24,'Spotify Canvas story (presave link in bio)','presave_cta','own',NULL,NULL,
    472,NULL,25,1,21,2,2,NULL,NULL,           164,52,24,6),
(25,'Countdown: Saaye out tonight at midnight','presave_cta','own',NULL,NULL,
    1786,1378,32,3,24,5,3,NULL,70.6,          209,39,35,16),
(26,'Close Friends: release more important than my birthday','close_friends','own',NULL,NULL,
    24,21,6,0,6,0,0,NULL,0.0,                 19,0,0,2),
(27,'sabahbanomalik reshare of countdown (so pumped)','reshare','reshare','@sabahbanomalik',NULL,
    318,221,11,5,10,0,1,11,16.0,              212,33,11,31),
(28,'Thank-you credits + Stream Now (Spotify)','stream_cta','own',NULL,NULL,
    267,200,13,3,12,0,1,5,16.9,               157,37,19,15),
(29,'Sabah reshare: ITTTSSSS HERRREEEE streaming now','reshare','reshare','@sabahbanomalik',NULL,
    489,353,16,4,13,1,2,6,44.6,               141,46,15,26),
(30,'Close Friends: SoundCloud link','close_friends','own',NULL,NULL,
    23,18,2,0,1,1,0,NULL,0.0,                 15,3,1,4),
(31,'It''s out! Stream Saaye (Spotify link)','stream_cta','own',NULL,NULL,
    976,804,13,0,12,0,1,NULL,69.2,            122,31,13,14),
(32,'Check this out!!! (Spotify card, tags @meerhunmein)','stream_cta','own',NULL,NULL,
    185,153,12,0,12,0,0,2,16.8,               130,21,12,10),
(33,'Notebook-style Spotify card (tags @artsbyanas._)','stream_cta','own',NULL,NULL,
    171,144,11,1,11,0,0,3,19.3,               124,17,8,10),
(34,'Thank you @itsdesifrequency - Weekly Frequency feature','press_feature','own',NULL,NULL,
    175,142,16,0,13,3,0,NULL,19.4,            94,44,8,13),
(35,'Photo + Saaye Spotify card (tags @seroores_)','stream_cta','own',NULL,NULL,
    237,193,6,1,6,0,0,2,15.2,                 165,27,20,5),
(36,'Sabah reshare: selfie video with hearts','reshare','reshare','@sabahbanomalik',NULL,
    356,286,32,4,26,2,4,14,12.9,              194,74,29,14),
(37,'Black story with OPEN.SPOTIFY.COM link','stream_cta','own',NULL,NULL,
    234,208,16,2,12,1,3,NULL,13.7,            131,34,30,0),
(38,'TikTok link story','stream_cta','own',NULL,NULL,
    202,187,8,1,6,0,2,NULL,13.4,              131,28,23,3),
(39,'You can Shazam Saaye','stream_cta','own',NULL,NULL,
    180,166,8,0,7,1,0,NULL,11.7,              148,9,13,2),
(40,'Purple story with Open.spotify.com link','stream_cta','own',NULL,NULL,
    235,198,11,1,11,0,0,NULL,10.6,            158,26,27,2),
(41,'SoundCloud link: This song','stream_cta','own',NULL,NULL,
    263,217,5,0,5,0,0,NULL,8.7,               175,31,16,23),
-- 42-44 reserved: '7 days / 306 streams' milestone, 217-viewer video, 'everything by duskus' reply (not yet captured)
(45,'Question sticker reply: Saaye by Sarah Afreen Malik - Great taste!','fan_reply','own',NULL,NULL,
    219,185,5,0,4,1,0,NULL,2.7,               140,32,20,11);

-- Link clicks (only stories with a link sticker)
ALTER TABLE ig_stories ADD COLUMN link_clicks INT;
UPDATE ig_stories SET link_clicks = 9 WHERE story_id = 20;

-- Audience gender (% men; women = 100 - this), where captured
ALTER TABLE ig_stories ADD COLUMN men_pct DECIMAL(4,1);
UPDATE ig_stories SET men_pct = 83.4 WHERE story_id = 17;
UPDATE ig_stories SET men_pct = 42.8 WHERE story_id = 20;
UPDATE ig_stories SET men_pct = 72.8 WHERE story_id = 21;
UPDATE ig_stories SET men_pct = 73.1 WHERE story_id = 22;
UPDATE ig_stories SET men_pct = 75.5 WHERE story_id = 23;
UPDATE ig_stories SET men_pct = 76.1 WHERE story_id = 24;
UPDATE ig_stories SET link_clicks = 3 WHERE story_id = 24;
UPDATE ig_stories SET men_pct = 40.3 WHERE story_id = 25;
UPDATE ig_stories SET link_clicks = 3 WHERE story_id = 25;
UPDATE ig_stories SET men_pct = 80.7 WHERE story_id = 28;
UPDATE ig_stories SET men_pct = 79.3 WHERE story_id = 29;
UPDATE ig_stories SET link_clicks = 1 WHERE story_id = 29;
UPDATE ig_stories SET men_pct = 38.4 WHERE story_id = 31;
UPDATE ig_stories SET link_clicks = 1 WHERE story_id = 31;
UPDATE ig_stories SET men_pct = 76.4 WHERE story_id = 32;
UPDATE ig_stories SET men_pct = 72.1 WHERE story_id = 34;
UPDATE ig_stories SET men_pct = 75.4 WHERE story_id = 35;
UPDATE ig_stories SET men_pct = 67.0 WHERE story_id = 36;
UPDATE ig_stories SET men_pct = 75.1 WHERE story_id = 37;
UPDATE ig_stories SET men_pct = 77.3 WHERE story_id = 38;
UPDATE ig_stories SET men_pct = 78.8 WHERE story_id = 39;
UPDATE ig_stories SET men_pct = 79.8 WHERE story_id = 40;
UPDATE ig_stories SET men_pct = 76.8 WHERE story_id = 41;
UPDATE ig_stories SET men_pct = 76.5 WHERE story_id = 45;

-- Stories added 12 Oct from later screenshots (post dates known)
INSERT INTO ig_stories
 (story_id, story_label, content_type, made_by, reshared_from, post_date,
  views, viewers, interactions, profile_activity, likes, replies, shares, sticker_taps,
  nonfollower_view_pct, taps_forward, exits, next_story, taps_back)
VALUES
(42,'Reshare: "your current on repeat song" Spotify player','reshare','reshare',NULL,'2026-10-05',
 259,207,14,6,12,2,0,NULL,10.8,131,57,32,1),
(43,'Reshare: "Go listen to this song by a friend of mine" (SoundCloud)','reshare','reshare',NULL,'2026-10-07',
 170,150,6,1,NULL,NULL,NULL,NULL,11.8,NULL,NULL,NULL,NULL),
(44,'Saaye Spotify card on pink, tags @sarahafreenmalik','stream_cta','own',NULL,'2026-10-09',
 394,328,8,3,NULL,NULL,NULL,NULL,5.8,NULL,NULL,NULL,NULL);

-- Sabah's selfie-video reshare: post date and viewers confirmed
UPDATE ig_stories SET post_date = '2026-10-03', viewers = 286 WHERE story_id = 36;

-- Milestone story (completes the highlight) + like/send/reply detail for 43 and 44
INSERT INTO ig_stories
 (story_id, story_label, content_type, made_by, reshared_from, post_date,
  views, viewers, interactions, profile_activity, likes, replies, shares, sticker_taps,
  nonfollower_view_pct, taps_forward, exits, next_story, taps_back)
VALUES
(46,'Milestone: In 7 days, from 9 to 110 monthly listeners (completely organic)','milestone','own',NULL,'2026-10-09',
 421,NULL,29,4,24,4,1,NULL,NULL,NULL,NULL,NULL,NULL);

UPDATE ig_stories SET likes = 6, shares = 0, replies = 0 WHERE story_id = 43;
UPDATE ig_stories SET likes = 7, shares = 1, replies = 0 WHERE story_id = 44;

-- Q6. Gender mix by story
SELECT story_id, story_label, views, men_pct, 100 - men_pct AS women_pct
FROM ig_stories
WHERE men_pct IS NOT NULL
ORDER BY story_id;

-- Q1. Interaction rate per story (engagement quality, not just reach)
SELECT story_id, story_label, views, interactions,
       ROUND(interactions / views * 100, 1) AS interaction_rate_pct
FROM ig_stories
ORDER BY interaction_rate_pct DESC;

-- Q2. Own content vs reshares
SELECT made_by,
       COUNT(*)                                        AS stories,
       ROUND(AVG(views), 0)                            AS avg_views,
       ROUND(SUM(interactions) / SUM(views) * 100, 1)  AS interaction_rate_pct,
       SUM(profile_activity)                           AS profile_visits
FROM ig_stories
GROUP BY made_by;

-- Q3. By content type
SELECT content_type,
       ROUND(AVG(views), 0)                            AS avg_views,
       ROUND(SUM(interactions) / SUM(views) * 100, 1)  AS interaction_rate_pct
FROM ig_stories
GROUP BY content_type
ORDER BY interaction_rate_pct DESC;

-- Q4. Drop-off through the highlight (retention vs first story)
SELECT story_id, story_label, views,
       ROUND(views / FIRST_VALUE(views) OVER (ORDER BY story_id) * 100, 0)
           AS pct_of_story1,
       views - LAG(views) OVER (ORDER BY story_id) AS change_vs_prev
FROM ig_stories
ORDER BY story_id;

-- Q5. Navigation behaviour (where captured)
SELECT story_label,
       taps_forward + exits + next_story + taps_back      AS navigation_total,
       ROUND(taps_forward / (taps_forward + exits + next_story + taps_back) * 100, 0)
           AS pct_forward,
       ROUND(exits / views * 100, 1)                       AS exit_rate_pct
FROM ig_stories
WHERE taps_forward IS NOT NULL;

-- =====================================================================
-- REELS
-- =====================================================================
CREATE TABLE ig_reels (
    reel_id              INT PRIMARY KEY,
    reel_label           VARCHAR(80),
    post_date            DATE,
    views                INT,
    viewers              INT,
    avg_watch_sec        INT,
    likes                INT,
    comments             INT,
    reposts              INT,
    shares               INT,
    saves                INT,
    profile_visits       INT,
    bio_link_clicks      INT,
    follows              INT,
    nonfollower_view_pct DECIMAL(4,1),
    skip_rate_pct        DECIMAL(4,1),
    typical_reel_views   INT          -- Instagram's "your typical reel" benchmark (approx, read from chart)
);

INSERT INTO ig_reels VALUES
(1,'CityFM89 Destination Srinagar feature','2026-09-19',
 1385,878,8,30,16,5,2,2,12,1,0,53.3,76.5,3000);

CREATE TABLE ig_reel_age (
    reel_id   INT,
    age_band  VARCHAR(10),
    pct       DECIMAL(4,1)
);

INSERT INTO ig_reel_age VALUES
(1,'13-17',1.3),(1,'18-24',16.4),(1,'25-34',60.2),(1,'35-44',19.7),
(1,'45-54',1.8),(1,'55-64',0.4),(1,'65+',0.3);

-- R1. Reel engagement rates
SELECT reel_label, views,
       ROUND((likes + comments + reposts + shares + saves) / views * 100, 1) AS engagement_rate_pct,
       ROUND(profile_visits / viewers * 100, 1) AS profile_visit_rate_pct,
       ROUND(views / typical_reel_views * 100, 0) AS pct_of_typical_reel
FROM ig_reels;

-- R2. Reel vs story reach for the same CityFM content
SELECT 'Reel' AS format, views, nonfollower_view_pct, profile_visits
FROM ig_reels WHERE reel_id = 1
UNION ALL
SELECT 'Story #16', views, nonfollower_view_pct, profile_activity
FROM ig_stories WHERE story_id = 16;

-- ---------------------------------------------------------------------
-- Reel 2 + traffic sources
-- ---------------------------------------------------------------------
ALTER TABLE ig_reels ADD COLUMN length_sec INT;
UPDATE ig_reels SET length_sec = 60 WHERE reel_id = 1;

INSERT INTO ig_reels
 (reel_id, reel_label, post_date, views, viewers, avg_watch_sec, likes, comments, reposts,
  shares, saves, profile_visits, bio_link_clicks, follows, nonfollower_view_pct,
  skip_rate_pct, typical_reel_views, length_sec)
VALUES
(2,'Lyrical reel: I''m so delusional','2026-09-16',
 9732,6918,6,200,129,31,56,9,136,NULL,2,67.2,69.4,3000,19);

INSERT INTO ig_reel_age VALUES
(2,'13-17',1.8),(2,'18-24',19.4),(2,'25-34',54.8),(2,'35-44',19.8),
(2,'45-54',3.0),(2,'55-64',0.6),(2,'65+',0.6);

CREATE TABLE ig_reel_sources (
    reel_id  INT,
    source   VARCHAR(20),
    pct      DECIMAL(4,1)
);

INSERT INTO ig_reel_sources VALUES
(1,'Feed',42.5),(1,'Profile',26.5),(1,'Stories',12.8),(1,'Reels tab',8.5),(1,'Explore',1.9),
(2,'Stories',37.7),(2,'Feed',32.6),(2,'Reels tab',12.6),(2,'Profile',5.8),(2,'Explore',2.3);

-- R3. Where each reel's views came from (estimated view counts)
SELECT r.reel_label, s.source, s.pct,
       ROUND(r.views * s.pct / 100) AS est_views
FROM ig_reel_sources s
JOIN ig_reels r ON r.reel_id = s.reel_id
ORDER BY r.reel_id, s.pct DESC;

-- R4. Reel head-to-head
SELECT reel_label, views, length_sec, avg_watch_sec,
       ROUND(avg_watch_sec / length_sec * 100, 0)          AS pct_watched,
       skip_rate_pct,
       ROUND(comments / views * 100, 2)                     AS comment_rate_pct,
       ROUND(shares / views * 100, 2)                       AS share_rate_pct,
       ROUND(profile_visits / viewers * 100, 1)             AS profile_visit_rate_pct,
       follows,
       ROUND(views / typical_reel_views, 1)                 AS x_typical_reel
FROM ig_reels;

-- ---------------------------------------------------------------------
-- Reel 3: tere saaye mein hoon (8s lyrical)
-- Views jumped from ~4.9K to ~8.8K around Oct 8-9 (second wave)
-- ---------------------------------------------------------------------
INSERT INTO ig_reels
 (reel_id, reel_label, post_date, views, viewers, avg_watch_sec, likes, comments, reposts,
  shares, saves, profile_visits, bio_link_clicks, follows, nonfollower_view_pct,
  skip_rate_pct, typical_reel_views, length_sec)
VALUES
(3,'Lyrical reel: tere saaye mein hoon','2026-09-21',
 8877,6619,2,91,12,10,17,4,64,NULL,5,NULL,82.2,2700,8);

INSERT INTO ig_reel_sources VALUES
(3,'Stories',62.2),(3,'Feed',20.3),(3,'Reels tab',8.1),(3,'Profile',1.7),(3,'Explore',1.0);

-- R5. Follow conversion per reel (the only follows in the whole campaign)
SELECT reel_label, viewers, profile_visits, follows,
       ROUND(follows / profile_visits * 100, 1) AS visit_to_follow_pct,
       ROUND(follows / viewers * 1000, 2)       AS follows_per_1k_viewers
FROM ig_reels
ORDER BY follows DESC;

-- ---------------------------------------------------------------------
-- Reel 3 audience + Reel 4: Studio Session 1 (making-of / BTS)
-- ---------------------------------------------------------------------
UPDATE ig_reels SET nonfollower_view_pct = 43.7 WHERE reel_id = 3;

INSERT INTO ig_reel_age VALUES
(3,'13-17',12.2),(3,'18-24',34.5),(3,'25-34',35.6),(3,'35-44',14.0),
(3,'45-54',2.6),(3,'55-64',0.6),(3,'65+',0.4);

INSERT INTO ig_reels
 (reel_id, reel_label, post_date, views, viewers, avg_watch_sec, likes, comments, reposts,
  shares, saves, profile_visits, bio_link_clicks, follows, nonfollower_view_pct,
  skip_rate_pct, typical_reel_views, length_sec)
VALUES
(4,'BTS: Studio Session 1 - who messed up her vocal comp in Lahore','2026-09-15',
 2122,1390,14,27,1,2,5,2,43,NULL,1,58.5,58.2,3400,34);

INSERT INTO ig_reel_age VALUES
(4,'13-17',1.0),(4,'18-24',17.2),(4,'25-34',55.2),(4,'35-44',22.4),
(4,'45-54',2.3),(4,'55-64',1.2),(4,'65+',0.8);

INSERT INTO ig_reel_sources VALUES
(4,'Feed',40.8),(4,'Profile',25.6),(4,'Reels tab',17.5),(4,'Stories',9.7),(4,'Explore',2.7);

-- R6. Under-25 share of audience per reel
SELECT r.reel_label,
       SUM(CASE WHEN a.age_band IN ('13-17','18-24') THEN a.pct ELSE 0 END) AS under_25_pct,
       SUM(CASE WHEN a.age_band = '25-34' THEN a.pct ELSE 0 END)            AS age_25_34_pct
FROM ig_reels r
JOIN ig_reel_age a ON a.reel_id = r.reel_id
GROUP BY r.reel_id, r.reel_label
ORDER BY r.reel_id;

-- ---------------------------------------------------------------------
-- Reel 5: Performance video (singing on camera with mic), posted Sep 6
-- Only reel Instagram rates "Lower" skip rate and "Higher" share rate
-- ---------------------------------------------------------------------
INSERT INTO ig_reels
 (reel_id, reel_label, post_date, views, viewers, avg_watch_sec, likes, comments, reposts,
  shares, saves, profile_visits, bio_link_clicks, follows, nonfollower_view_pct,
  skip_rate_pct, typical_reel_views, length_sec)
VALUES
(5,'Performance: singing Saaye on camera with mic','2026-09-06',
 8098,5711,11,138,38,7,333,6,298,2,4,NULL,45.9,NULL,53);

INSERT INTO ig_reel_sources VALUES
(5,'Feed',42.2),(5,'Reels tab',24.6),(5,'Profile',14.5),(5,'Explore',5.8),
(5,'Stories',4.4),(5,'Search',3.1);

-- R7. Algorithmic discovery vs. story-driven views
-- (Reels tab + Explore + Search = Instagram recommending you to strangers)
SELECT r.reel_label,
       SUM(CASE WHEN s.source IN ('Reels tab','Explore','Search') THEN s.pct ELSE 0 END) AS algorithmic_pct,
       SUM(CASE WHEN s.source = 'Stories' THEN s.pct ELSE 0 END)                         AS stories_pct,
       ROUND(r.shares / r.views * 100, 1)                                                 AS share_rate_pct,
       ROUND(r.profile_visits / r.viewers * 100, 1)                                       AS profile_visit_rate_pct
FROM ig_reels r
JOIN ig_reel_sources s ON s.reel_id = r.reel_id
GROUP BY r.reel_id, r.reel_label, r.shares, r.views, r.profile_visits, r.viewers
ORDER BY algorithmic_pct DESC;

-- Reel 5 audience
UPDATE ig_reels SET nonfollower_view_pct = 75.7 WHERE reel_id = 5;

INSERT INTO ig_reel_age VALUES
(5,'13-17',0.4),(5,'18-24',11.8),(5,'25-34',59.2),(5,'35-44',24.4),
(5,'45-54',2.7),(5,'55-64',0.8),(5,'65+',0.6);

-- R8. Reach into new audiences: estimated non-follower viewers per reel
SELECT reel_label, viewers, nonfollower_view_pct,
       ROUND(viewers * nonfollower_view_pct / 100) AS est_new_people_reached,
       follows
FROM ig_reels
ORDER BY est_new_people_reached DESC;

-- ---------------------------------------------------------------------
-- Account-level Instagram context (Professional dashboard)
-- ---------------------------------------------------------------------
CREATE TABLE ig_account_summary (
    period_label         VARCHAR(30),
    period_start         DATE,
    period_end           DATE,
    views                INT,
    views_change_pct     DECIMAL(5,1),   -- vs the previous period of the same length
    nonfollower_view_pct DECIMAL(4,1),
    followers            INT,
    net_followers        INT,
    is_rounded           BOOLEAN         -- monthly recap shows rounded figures (98K, 17K)
);
INSERT INTO ig_account_summary VALUES
('September recap','2026-09-01','2026-09-30',98000,NULL,54.0,17000,NULL,TRUE),
('14 days after release','2026-09-28','2026-10-11',28233,-42.3,NULL,17393,-27,FALSE);

-- A2. Did the Instagram reel audience become the Spotify audience?
-- Instagram reel ages weighted by each reel's viewers vs Spotify listener ages
WITH ig AS (
    SELECT CASE WHEN a.age_band = '13-17' THEN '<18' ELSE a.age_band END AS age_band,
           SUM(a.pct * r.viewers) / SUM(r.viewers) AS ig_reel_pct
    FROM ig_reel_age a
    JOIN ig_reels r ON r.reel_id = a.reel_id
    GROUP BY 1
)
SELECT ig.age_band,
       ROUND(ig.ig_reel_pct, 1)            AS instagram_reel_viewers_pct,
       s.pct                               AS spotify_listeners_pct,
       ROUND(s.pct - ig.ig_reel_pct, 1)    AS difference_pts
FROM ig
JOIN spotify_audience_age s ON s.age_band = ig.age_band
ORDER BY FIELD(ig.age_band, '<18','18-24','25-34','35-44','45-54','55-64','65+');

-- A4. Gender: everyday stories vs the three release-moment stories vs Spotify listeners
SELECT 'Everyday stories' AS audience,
       ROUND(100 - SUM(men_pct * views) / SUM(views), 1) AS women_pct
FROM ig_stories
WHERE men_pct IS NOT NULL AND story_id NOT IN (20, 25, 31)
UNION ALL
SELECT 'Pre-save, countdown and release-day stories',
       ROUND(100 - SUM(men_pct * views) / SUM(views), 1)
FROM ig_stories
WHERE story_id IN (20, 25, 31)
UNION ALL
SELECT 'Spotify listeners (last 28 days)', pct
FROM spotify_audience_gender
WHERE gender = 'Female';

-- D2. Data completeness: stories without a post date
SELECT COUNT(*)                                  AS stories,
       SUM(post_date IS NULL)                    AS missing_date,
       ROUND(SUM(post_date IS NULL) / COUNT(*) * 100, 0) AS pct_missing
FROM ig_stories;
