{{
    config(
        materialized='incremental',
        unique_key='result_id',
        on_schema_change='sync_all_columns'
    )
}}

/*
  fct_race_results
  ----------------
  The core fact table at result grain (one row per driver per race).
  Materialized incrementally, keyed on result_id.

  In a production setting the incremental filter would use a loaded_at
  timestamp from the source. Since our data is seeded (no timestamp),
  we filter on race_date so the pattern is clear for discussion.
*/

with enriched as (
    select * from {{ ref('int_race_results_enriched') }}

    {% if is_incremental() %}
        -- only process races that arrived after the latest race already loaded
        where race_date > (select max(race_date) from {{ this }})
    {% endif %}
)

select
    {{ dbt_utils.generate_surrogate_key(['result_id']) }}  as fct_result_sk,
    result_id,
    race_id,
    driver_id,
    constructor_id,
    season,
    round,
    race_name,
    circuit_id,
    race_date,
    race_country,
    driver_code,
    driver_name,
    constructor_name,
    finish_position,
    grid_position,
    positions_gained,
    points,
    status,
    fastest_lap,
    laps_completed,
    finished_race,
    won_race,
    podium_finish,
    points_finish,
    current_timestamp()  as dbt_loaded_at
from enriched
