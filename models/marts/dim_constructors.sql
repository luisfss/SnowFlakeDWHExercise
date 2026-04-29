/*
  dim_constructors
  ----------------
  Constructor dimension denormalized with season standings.
  Reads exclusively from the intermediate layer.
*/

with season_stats as (
    select * from {{ ref('int_constructor_season_stats') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['constructor_id', 'season']) }} as dim_constructor_sk,
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