# DWF1 dbt Project

A minimal dbt project built on F1 2023 season data, designed to demonstrate
project structure, layered transformations, and key dbt features.

## Stack

- **Database:** Snowflake
- **Transformation:** dbt Core
- **Packages:** dbt-labs/dbt_utils

## Project Structure

```
dwf1_dbt/
├── seeds/                      # Raw CSV data (races, drivers, constructors, results)
├── models/
│   ├── staging/                # Materialized as views; rename and type raw columns
│   ├── intermediate/           # Materialized as tables; aggregations and enrichment
│   └── marts/                  # BI-ready layer; fact table is incremental
├── macros/
│   ├── limit_dev.sql           # Appends LIMIT in dev target, no-op in prod
│   └── points_to_tier.sql      # Classifies points totals into performance tiers
└── tests/
    ├── assert_points_not_negative.sql
    └── assert_one_winner_per_race.sql
```

## Lineage

```
seeds (raw)
  └── stg_races / stg_drivers / stg_constructors / stg_results   [views]
        └── int_race_results_enriched                             [table]
        └── int_driver_season_stats                               [table]
        └── int_constructor_season_stats                          [table]
              └── fct_race_results     [incremental, unique_key=result_id]
              └── dim_drivers          [table]
              └── dim_constructors     [table]
```

## Setup

1. Copy `profiles.yml.template` to `~/.dbt/profiles.yml` and fill in your Snowflake credentials.
2. Install dependencies:
   ```bash
   dbt deps
   ```
3. Load seed data:
   ```bash
   dbt seed
   ```
4. Run all models:
   ```bash
   dbt run
   ```
5. Run tests:
   ```bash
   dbt test
   ```
6. Generate and serve docs:
   ```bash
   dbt docs generate && dbt docs serve
   ```

## Key Design Decisions

**Staging as views** — no storage cost, always reflect the latest seed data.

**Intermediate as tables** — the aggregations are non-trivial; materializing
them prevents redundant computation when multiple marts reference the same logic.

**Fact table as incremental** — demonstrates the pattern for append-heavy
transactional data. The watermark is `race_date`; in a real pipeline this would
be a `loaded_at` timestamp from the source system.

**Surrogate keys via dbt_utils** — `generate_surrogate_key` hashes the natural
key into a consistent SK, making joins explicit and future-proof.

**Macros for reusable logic** — `points_to_tier` centralises classification
thresholds; `limit_dev` speeds up dev runs without touching model SQL.

**Singular tests for business rules** — generic tests cover column-level
constraints; singular tests encode domain rules (one winner per race,
no negative points) that are harder to express generically.
