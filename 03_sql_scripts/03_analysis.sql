-- ============================================================
-- FILE: 03_analysis.sql
-- PROJECT: Cyclistic Bike-Share Analysis
-- ANALYST: Bennettullah
-- PURPOSE: Six analytical queries answering business questions
-- DATASET: cyclistic_trips_clean (5,438,912 rows)
-- ============================================================
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUERY 1: OVERALL RIDER SPLIT
-- Business Question: What is the overall ratio of members to casual riders?
-- Technique: Window function SUM(COUNT(*)) OVER() for grand total
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SELECT
  member_casual AS rider_type,
  COUNT(*) AS total_rides,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage_of_rides
FROM cyclistic_trips_clean
GROUP BY member_casual
ORDER BY total_rides DESC;
-- RESULT:
-- member 3,512,651 64.58%
-- casual 1,926,261 35.42%
-- EXPORT AS: 01_rider_split.csv
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUERY 2: AVERAGE RIDE DURATION
-- Business Question: Who rides longer? Reveals fundamentally different use cases
-- Technique: CTE + MIN() OVER() window function for % comparison
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WITH avg_duration AS (
  SELECT
    member_casual AS rider_type,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_minutes,
    ROUND(MIN(ride_length_minutes), 2) AS min_ride_minutes,
    ROUND(MAX(ride_length_minutes), 2) AS max_ride_minutes
  FROM cyclistic_trips_clean
  GROUP BY member_casual
)
SELECT
  rider_type,
  avg_ride_minutes,
  min_ride_minutes,
  max_ride_minutes,
  ROUND(
    (avg_ride_minutes - MIN(avg_ride_minutes) OVER()) /
    MIN(avg_ride_minutes) OVER() * 100
  , 2) AS pct_longer_than_shortest
FROM avg_duration
ORDER BY avg_ride_minutes DESC;
-- RESULT:
-- casual 19.89 min 63.97% longer than members
-- member 12.13 min baseline (0.00%)
-- EXPORT AS: 02_avg_duration.csv
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUERY 3: RIDES BY DAY OF WEEK
-- Business Question: Which days does each rider type use Cyclistic most?
-- Technique: CASE WHEN for custom sort order (Sun=1 through Sat=7)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SELECT
  member_casual AS rider_type,
  day_of_week,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length_minutes), 2) AS avg_ride_minutes
FROM cyclistic_trips_clean
GROUP BY member_casual, day_of_week
ORDER BY member_casual,
  CASE day_of_week
    WHEN 'Sunday' THEN 1
    WHEN 'Monday' THEN 2
    WHEN 'Tuesday' THEN 3
    WHEN 'Wednesday' THEN 4
    WHEN 'Thursday' THEN 5
    WHEN 'Friday' THEN 6
    WHEN 'Saturday' THEN 7
  END;
-- RESULT (selected rows):
-- casual Saturday 397,019 rides 22.38 avg min (PEAK)
-- member Thursday 566,999 rides 11.71 avg min (PEAK)
-- EXPORT AS: 03_day_of_week.csv
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUERY 4: MONTHLY SEASONAL TRENDS
-- Business Question: What seasonal patterns exist? Reveals campaign timing
-- Technique: ORDER BY month_num (numeric) for correct chronological order
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SELECT
  member_casual AS rider_type,
  month_num,
  month_name,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length_minutes), 2) AS avg_ride_minutes
FROM cyclistic_trips_clean
GROUP BY member_casual, month_num, month_name
ORDER BY member_casual, month_num;
-- RESULT (selected):
-- casual 08 August 323,566 rides (PEAK — 47.3% Jun-Aug combined)
-- casual 01 January 23,405 rides (LOWEST)
-- member usage consistent year-round
-- EXPORT AS: 04_monthly.csv
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUERY 5: BIKE TYPE PREFERENCE
-- Business Question: Which bike types does each rider type prefer?
-- Technique: PARTITION BY in OVER() for within-group percentages
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SELECT
  member_casual AS rider_type,
  rideable_type AS bike_type,
  COUNT(*) AS total_rides,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2)
  AS pct_within_rider_type,
  ROUND(AVG(ride_length_minutes), 2) AS avg_ride_minutes
FROM cyclistic_trips_clean
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_rides DESC;
-- RESULT:
-- casual electric_bike 1,252,181 65.01% 14.89 avg min
-- casual classic_bike 674,080 34.99% 29.16 avg min (HIGHEST engagement!)
-- member electric_bike 2,218,635 63.16% 11.34 avg min
-- member classic_bike 1,294,016 36.84% 13.50 avg min
-- EXPORT AS: 05_bike_type.csv
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUERY 6: TOP 10 START STATIONS PER RIDER TYPE
-- Business Question: Where do casual riders start trips? Enables geo-targeting
-- Technique: ROW_NUMBER() OVER(PARTITION BY) for top-N-per-group
-- TRIM() to catch blank station names (not technically NULL)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WITH ranked_stations AS (
  SELECT
    member_casual AS rider_type,
    start_station_name,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_minutes,
    ROW_NUMBER() OVER(
      PARTITION BY member_casual
      ORDER BY COUNT(*) DESC
    ) AS rank_within_group
  FROM cyclistic_trips_clean
  WHERE TRIM(start_station_name) != ''
  GROUP BY member_casual, start_station_name
)
SELECT
  rider_type,
  rank_within_group AS rank,
  start_station_name,
  total_rides,
  avg_ride_minutes
FROM ranked_stations
WHERE rank_within_group <= 10
ORDER BY rider_type, rank_within_group;
-- RESULT:
-- CASUAL TOP 3: DuSable Lake Shore & Monroe (30,894) | Navy Pier (26,648) | Streeter Dr (23,714)
-- MEMBER TOP 3: Kingsbury & Kinzie (32,014) | Clinton & Washington (25,635) | Clinton
--& Madison (22,234)
-- ZERO overlap between casual and member top 10 stations
-- EXPORT AS: 06_top_stations.csv
