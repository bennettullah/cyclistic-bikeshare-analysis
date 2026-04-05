# Cyclistic Bike-Share Analysis

### Google Data Analytics Professional Certificate — Capstone Project

[![Tableau](https://img.shields.io/badge/Tableau-Dashboard-blue)](https://public.tableau.com/app/profile/bennett.ullah/viz/CyclisticDashboardBikeShareAnalysis-Tableau/Dashboard1)
[![SQL](https://img.shields.io/badge/SQL-SQLite-green)](https://github.com/bennettullah/cyclistic-bikeshare-analysis/blob/main/03_sql_scripts)
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://github.com/bennettullah/cyclistic-bikeshare-analysis/blob/main/LICENSE)

---

## Project Overview

This analysis examines 12 months of Cyclistic bike-share trip data (December 2024 — November 2025) to identify behavioural differences between casual riders and annual members, informing a data-driven marketing strategy to convert casual riders into annual members.

**Live Dashboard:** [View Interactive Dashboard on Tableau Public](https://public.tableau.com/app/profile/bennett.ullah/viz/CyclisticDashboardBikeShareAnalysis-Tableau/Dashboard1)

---

## Business Task

> *How do annual members and casual riders use Cyclistic bikes differently?*

---

## Tools Used

| Tool | Purpose |
| --- | --- |
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
- **License:** [Motivate International Inc. Public Data License Agreement](https://divvybikes.com/data-license-agreement)

---

## Key Findings

| # | Finding | Impact |
| --- | --- | --- |
| 1 | Members account for **64.58%** of rides; casuals **35.42%** (1.9M trips) | Large conversion opportunity |
| 2 | Casual riders average **19.89 mins/trip** vs members **12.13 mins** — 64% longer | Different use cases confirmed |
| 3 | Casuals peak on **Saturday**; members peak **Tuesday–Thursday** | Completely opposite patterns |
| 4 | **47%** of casual rides occur June–August — extreme seasonality | Campaign timing: May–June |
| 5 | Casual top stations: tourist attractions (Navy Pier, Millennium Park) | Geo-targeting opportunity |
| 6 | Member top stations: transit hubs and business district intersections | Zero geographic overlap |

---

## Top 3 Recommendations

1. **Weekend Station Marketing** — Deploy signage at top casual stations on Friday evenings and Saturday mornings to reach riders at peak engagement.Success metric: 8% increase in new memberships at targeted stations within 90 days of campaign launch and track new memberships originating from targeted stations.
3. **Spring Membership Drive** — Launch a time-limited discounted annual membership promotion in May–June, before casual riders commit their peak-season spending to single-ride passes. Success metric: 10% uplift in May–June membership sales versus the prior 12-month monthly average and track conversion rate of casual riders entering peak season.
4. **Geofenced Digital Advertising** — Target mobile devices within 500m of the top 10 casual stations on weekends during May–October. Success metric: Cost-per-acquisition from geofenced campaign versus non-targeted digital advertising channels and track conversion rate from ad engagement to membership sign-up.

---

## Repository Structure
```
cyclistic-bikeshare-analysis/
├── 02_processed_data/          # Aggregated CSV exports for Tableau
│   ├── 01_rider_split.csv
│   ├── 02_avg_duration.csv
│   ├── 03_day_of_week.csv
│   ├── 04_monthly.csv
│   ├── 05_bike_type.csv
│   └── 06_top_stations.csv
├── 03_sql_scripts/             # All SQL scripts documented
│   ├── 01_create_table.sql     # Table creation DDL
│   ├── 02_data_cleaning.sql    # Quality checks + clean table
│   └── 03_analysis.sql         # Six analytical queries
├── LICENSE
└── README.md
```

---

## Data Cleaning Summary

| Check | Finding | Action |
| --- | --- | --- |
| Duplicate ride_ids | 0 duplicates | No action required |
| NULL values (9 columns) | 0 NULLs | No action required |
| Zero/negative duration | 29 rides | Excluded |
| Rides under 1 minute | 146,319 rides | Excluded |
| Rides over 24 hours | 5,601 rides | Excluded |
| **Total removed** | **151,920** | |
| **Final clean dataset** | **5,438,912** | ✓ Ready for analysis |

---

## Key Metrics at a Glance

| Metric | Value |
| --- | --- |
| Total raw records | 5,590,832 |
| Total clean records | 5,438,912 |
| Member ride share | 64.58% |
| Casual ride share | 35.42% |
| Casual average ride duration | 19.89 minutes |
| Member average ride duration | 12.13 minutes |
| Duration difference | Casuals ride 64% longer |
| Peak casual day | Saturday (397,019 rides) |
| Peak member day | Thursday (566,999 rides) |
| Top casual station | DuSable Lake Shore Dr & Monroe St |
| Top member station | Kingsbury St & Kinzie St |

---

## Contact

- **LinkedIn:** [linkedin.com/in/bennettullah](https://www.linkedin.com/in/bennettullah)
- **Tableau Public:** [bennett.ullah on Tableau Public](https://public.tableau.com/app/profile/bennett.ullah/viz/CyclisticDashboardBikeShareAnalysis-Tableau/Dashboard1)
- **GitHub:** [github.com/bennettullah](https://github.com/bennettullah)
