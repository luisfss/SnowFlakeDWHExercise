/*
  dim_constructors
  ----------------
  Constructor dimension denormalized with season standings.
  Reads exclusively from the intermediate layer.
*/

with season_stats as (
    select * from DWF1.dev_intermediate.int_constructor_season_stats
)

select
    md5(cast(coalesce(cast(constructor_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(season as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as dim_constructor_sk,
    constructor_id,
    constructor_name,
    nationality,
    season,
    championship_position,
    drivers_used,
    total_points,
    wins,
    podiums,
    fastest_laps,
    finish_rate_pct
from season_stats