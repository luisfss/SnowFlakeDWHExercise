/*
  dim_drivers
  -----------
  Driver dimension denormalized with season-level performance stats.
  Reads exclusively from the intermediate layer.
  One row per driver per season. Flat table intended for BI tools.
*/

with season_stats as (
    select * from {{ ref('int_driver_season_stats') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['driver_id', 'season']) }} as dim_driver_sk,
    driver_id,
    driver_code,
    full_name,
    nationality,
    date_of_birth,
    constructor_id,
    constructor_name,
    season,
    championship_position,
    races_entered,
    races_finished,
    total_points,
    wins,
    podiums,
    points_finishes,
    fastest_laps,
    finish_rate_pct,
    avg_finish_position,
    avg_grid_position,
    {{ points_to_tier('total_points') }} as performance_tier
from season_stats