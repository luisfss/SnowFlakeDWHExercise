
  
    

create or replace transient table DWF1.dev_marts.dim_drivers
    
    
    
    as (/*
  dim_drivers
  -----------
  Driver dimension denormalized with season-level performance stats.
  Reads exclusively from the intermediate layer.
  One row per driver per season. Flat table intended for BI tools.
*/

with season_stats as (
    select * from DWF1.dev_intermediate.int_driver_season_stats
)

select
    md5(cast(coalesce(cast(driver_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(season as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as dim_driver_sk,
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
    
    
    case
        when total_points >= 400 then 'Championship Contender'
        when total_points >= 200 then 'Race Winner'
        when total_points >= 100 then 'Points Scorer'
        when total_points >= 1   then 'Backmarker'
        else                              'No Points'
    end
 as performance_tier
from season_stats
    )
;


  