# Cyclistic Bike-Share Analysis
### Google Data Analytics Professional Certificate — Capstone Project
[![Tableau](https://img.shields.io/badge/Tableau-Dashboard-blue)](YOUR_TABLEAU_URL)
[![SQL](https://img.shields.io/badge/SQL-SQLite-green)](03_sql_scripts/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

## Project Overview

This analysis examines 12 months of Cyclistic bike-share trip data
(December 2024 — November 2025) to identify behavioural differences
between casual riders and annual members, informing a data-driven
marketing strategy to convert casual riders into annual members.

**Live Dashboard:** [View Interactive Dashboard on Tableau Public](YOUR_TABLEAU_URL)
---
## Business Task
> *How do annual members and casual riders use Cyclistic bikes differently?*
---
## Tools Used
| Tool | Purpose |
|------|---------|
| SQLite / DBeaver | Database, data cleaning, analysis |
| Tableau Public | Visualisation & interactive dashboard |
| Terminal (Mac) | Automation & batch import |
| GitHub | Version control & portfolio hosting |
---
## Dataset
- **Source:** Motivate International Inc. (Divvy Bikes Chicago)
- **Period:** December 2024 — November 2025 (12 months)
- **Raw records:** 5,590,832 | **Clean records:** 5,438,912
- **Records removed:** 151,920 (false starts, unreturned bikes, impossible durations)
- **License:** [Motivate International Inc. Public Data License Agreement](https://
divvybikes.com/data-license-agreement)
---
## Key Findings
| # | Finding | Impact |
|---|---------|--------|
| 1 | Members account for **64.58%** of rides; casuals **35.42%** (1.9M trips) | Large
conversion opportunity |
| 2 | Casual riders average **19.89 mins/trip** vs members **12.13 mins** (64% longer)
| Different use cases confirmed |
| 3 | Casuals peak **Saturday**; members peak **Tuesday–Thursday** | Completely
opposite patterns |
| 4 | **47%** of casual rides occur June–August — extreme seasonality | Campaign
timing: May–June |
| 5 | Casual top stations: tourist attractions (Navy Pier, Millennium Park) | Geo-
targeting opportunity |
| 6 | Member top stations: transit hubs and business district intersections | Zero
geographic overlap |
---
## Top 3 Recommendations
1. **Weekend Station Marketing** — Deploy signage at top casual stations Friday
evenings & Saturday mornings
2. **Spring Membership Drive** — Launch discounted membership promotion May–June
before peak casual season
3. **Geofenced Digital Advertising** — Target mobile devices within 500m of top casual
stations on weekends
---
## Repository Structure
```
cyclistic-bikeshare-analysis/
├── 02_processed_data/ │ ├── 01_rider_split.csv
# Aggregated CSV files exported for Tableau
│ ├── 02_avg_duration.csv
│ ├── 03_day_of_week.csv
│ ├── 04_monthly.csv
│ ├── 05_bike_type.csv
│ └── 06_top_stations.csv
├── 03_sql_scripts/ # All SQL scripts documented
│ ├── 01_create_table.sql # Table creation DDL
│ ├── 02_data_cleaning.sql # Quality checks + clean table
│ └── 03_analysis.sql # Six analytical queries
└── README.md # This file
```
---
## Data Cleaning Summary
| Check | Finding | Action |
|-------|---------|--------|
| Duplicate ride_ids | 0 duplicates | No action |
| NULL values (9 columns) | 0 NULLs | No action |
| Zero/negative duration | 29 rides | Excluded |
| Rides under 1 minute | 146,319 rides | Excluded |
| Rides over 24 hours | 5,601 rides | Excluded |
| **Total removed** | **151,920** | |
| **Final clean dataset** | **5,438,912** | ✓ Ready for analysis |
---
## Contact
- **LinkedIn:** [Your LinkedIn URL]
- **Kaggle:** [Your Kaggle URL]
- **Tableau Public:** [Your Tableau Profile URL]
