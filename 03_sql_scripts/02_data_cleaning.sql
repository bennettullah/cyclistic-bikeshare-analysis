FILE: 02_data_cleaning.sql
-- PROJECT: Cyclistic Bike-Share Analysis
-- ANALYST: Bennettullah
-- PURPOSE: Quality checks and clean table creation
-- RECORDS REMOVED: 151,920 | CLEAN RECORDS: 5,438,912
-- ============================================================
-- ────────────────────────────────────────────────────────────
-- BATCH IMPORT SCRIPT (run via Terminal, not DBeaver)
-- File paths are environment-specific.
-- Replace 'path/to/' with your local directory path before running this script.
-- ────────────────────────────────────────────────────────────
.mode csv
.headers on
.import --csv --skip 1 path/to/01_raw_data/202412-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202501-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202502-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202503-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202504-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202505-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202506-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202507-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202508-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202509-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202510-divvy-tripdata.csv cyclistic_trips
.import --csv --skip 1 path/to/01_raw_data/202511-divvy-tripdata.csv cyclistic_trips
-- ────────────────────────────────────────────────────────────
-- CHECK 1: TOTAL ROW COUNT
-- Expected: 5,590,832 rows across all 12 months
-- ────────────────────────────────────────────────────────────
SELECT COUNT(*) AS total_rows
FROM cyclistic_trips;
-- Result: 5,590,832 ✓
-- ────────────────────────────────────────────────────────────
-- CHECK 2: DUPLICATE DETECTION
-- ride_id should be unique — each trip has one ID
-- ────────────────────────────────────────────────────────────
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT ride_id) AS unique_rides,
COUNT(*) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM cyclistic_trips;
-- Result: 0 duplicates ✓
-- ────────────────────────────────────────────────────────────
-- CHECK 3: NULL VALUE AUDIT (all 9 critical columns)
-- ────────────────────────────────────────────────────────────
SELECT
SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS null_ride_id,
SUM(CASE WHEN rideable_type IS NULL THEN 1 ELSE 0 END) AS null_rideable_type,
SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS null_started_at,
SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS null_ended_at,
SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) AS null_start_station,
SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) AS null_end_station,
SUM(CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END) AS null_start_lat,
SUM(CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END) AS null_end_lat,
SUM(CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS null_member_casual
FROM cyclistic_trips;
-- Result: 0 NULLs across all 9 columns ✓
-- ────────────────────────────────────────────────────────────
-- CHECK 4: INVALID RIDE LENGTHS
-- strftime('%s') converts datetime text to Unix timestamp (seconds)
-- Subtracting gives duration in seconds
-- ────────────────────────────────────────────────────────────
SELECT
COUNT(*) AS total_rides,
SUM(CASE WHEN (
CAST(strftime('%s', ended_at) AS INTEGER) -
CAST(strftime('%s', started_at) AS INTEGER)
) <= 0 THEN 1 ELSE 0 END) AS zero_or_negative_rides,
SUM(CASE WHEN (
CAST(strftime('%s', ended_at) AS INTEGER) -
CAST(strftime('%s', started_at) AS INTEGER)
) < 60 THEN 1 ELSE 0 END) AS rides_under_1_min,
SUM(CASE WHEN (
CAST(strftime('%s', ended_at) AS INTEGER) -
CAST(strftime('%s', started_at) AS INTEGER)
) > 86400 THEN 1 ELSE 0 END) AS rides_over_24_hrs
FROM cyclistic_trips;
-- Results: 29 zero/negative | 146,319 under 1 min | 5,601 over 24 hrs
-- ────────────────────────────────────────────────────────────
-- CHECK 5: CATEGORICAL VALIDATION
-- Confirms exactly 2 valid values in member_casual column
-- ────────────────────────────────────────────────────────────
SELECT member_casual, COUNT(*) AS total_rides
FROM cyclistic_trips
GROUP BY member_casual
ORDER BY total_rides DESC;
-- Result: 'member' and 'casual' only — no typos or inconsistencies ✓
-- ────────────────────────────────────────────────────────────
-- CLEAN TABLE CREATION
-- Creates analytical table with derived columns
-- Excludes: rides < 60 seconds (false starts)
-- Excludes: rides > 86400 seconds / 24 hours (unreturned bikes)
-- ────────────────────────────────────────────────────────────
CREATE TABLE cyclistic_trips_clean AS
SELECT
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  start_station_name,
  start_station_id,
  end_station_name,
  end_station_id,
  start_lat,
  start_lng,
  end_lat,
  end_lng,
  member_casual,
  -- Derived column 1: Ride duration in seconds
  CAST(strftime('%s', ended_at) AS INTEGER) -
  CAST(strftime('%s', started_at) AS INTEGER)
    AS ride_length_seconds,
  -- Derived column 2: Ride duration in minutes (rounded to 2dp)
  ROUND((CAST(strftime('%s', ended_at) AS INTEGER) -
  CAST(strftime('%s', started_at) AS INTEGER)) / 60.0, 2)
    AS ride_length_minutes,
  -- Derived column 3: Day of week as readable name
  CASE strftime('%w', started_at)
    WHEN '0' THEN 'Sunday'
    WHEN '1' THEN 'Monday'
    WHEN '2' THEN 'Tuesday'
    WHEN '3' THEN 'Wednesday'
    WHEN '4' THEN 'Thursday'
    WHEN '5' THEN 'Friday'
    WHEN '6' THEN 'Saturday'
  END AS day_of_week,
  -- Derived column 4a: Month as number for correct sorting
  strftime('%m', started_at) AS month_num,
  
  -- Derived column 4b: Month as readable name
  CASE strftime('%m', started_at)
    WHEN '01' THEN 'January' 
    WHEN '02' THEN 'February'
    WHEN '03' THEN 'March' 
    WHEN '04' THEN 'April'
    WHEN '05' THEN 'May' 
    WHEN '06' THEN 'June'
    WHEN '07' THEN 'July' 
    WHEN '08' THEN 'August'
    WHEN '09' THEN 'September' 
    WHEN '10' THEN 'October'
    WHEN '11' THEN 'November' 
    WHEN '12' THEN 'December'
  END AS month_name
FROM cyclistic_trips
WHERE
  -- Exclude rides under 1 minute (false starts / accidental unlocks)
  CAST(strftime('%s', ended_at) AS INTEGER) -
  CAST(strftime('%s', started_at) AS INTEGER) >= 60
  AND
  -- Exclude rides over 24 hours (unreturned / stolen bikes)
  CAST(strftime('%s', ended_at) AS INTEGER) -
  CAST(strftime('%s', started_at) AS INTEGER) <= 86400;

-- Verification count — should return 5,438,912
SELECT COUNT(*) AS clean_rows FROM cyclistic_trips_clean;
-- ────────────────────────────────────────────────────────────
-- PERFORMANCE INDEXES
-- Indexes speed up GROUP BY and WHERE queries on large tables
-- Without indexes: full table scan of 5.4M rows every query
-- ────────────────────────────────────────────────────────────
CREATE INDEX idx_member_casual ON cyclistic_trips_clean(member_casual);
CREATE INDEX idx_started_at ON cyclistic_trips_clean(started_at);
CREATE INDEX idx_rideable_type ON cyclistic_trips_clean(rideable_type);
CREATE INDEX idx_day_of_week ON cyclistic_trips_clean(day_of_week);
CREATE INDEX idx_month_num ON cyclistic_trips_clean(month_num);
-- Verify all 5 indexes were created
SELECT name, tbl_name 
FROM sqlite_master 
WHERE type = 'index';
