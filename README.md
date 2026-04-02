# Cyclistic Bike-Share Analysis
### Google Data Analytics Professional Certificate — Capstone Project
[![Tableau](https://img.shields.io/badge/Tableau-Dashboard-blue)][https://public.tableau.com/app/profile/bennett.ullah/viz/CyclisticDashboardBikeShareAnalysis-Tableau/Dashboard1?publish=yes]
[![SQL](https://img.shields.io/badge/SQL-SQLite-green)](03_sql_scripts/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

## Project Overview

This analysis examines 12 months of Cyclistic bike-share trip data
(December 2024 — November 2025) to identify behavioural differences
between casual riders and annual members, informing a data-driven
marketing strategy to convert casual riders into annual members.

**Live Dashboard:** [View Interactive Dashboard on Tableau Public][https://public.tableau.com/app/profile/bennett.ullah/viz/CyclisticDashboardBikeShareAnalysis-Tableau/Dashboard1?publish=yes]
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

- Members account for 64.58% of rides; casual riders 35.42% (1.9M trips)
- Casual riders average 19.89 minutes vs members 12.13 minutes (64% longer than members)
- Casual riders peak on weekends; members peak midweek
- 47% of casual rides occur in summer (June–August)
- Casual riders use tourist stations; members use business/transit hubs
- Casual top stations: Navy Pier, Millennium Park.
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
├── 02_processed_data/
│ ├── 01_rider_split.csv
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
- **LinkedIn:** [www.linkedin.com/in/bennettullah]
- **Tableau Public:**[(https://public.tableau.com/app/profile/bennett.ullah/viz/CyclisticDashboardBikeShareAnalysis-Tableau/Dashboard1?publish=yes)]
