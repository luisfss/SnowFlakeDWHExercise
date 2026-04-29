/*
  int_race_results_enriched
  -------------------------
  Enriches the result grain with driver and race context.
  This is the "wide" intermediate that marts can slice without
  needing to re-join the dimension tables themselves.
*/

with results as (
    select * from DWF1.dev_staging.stg_results
),

races as (
    select * from DWF1.dev_staging.stg_races
),

drivers as (
    select * from DWF1.dev_staging.stg_drivers
),

constructors as (
    select * from DWF1.dev_staging.stg_constructors
),

enriched as (
    select
        -- keys
        r.result_id,
        r.race_id,
        r.driver_id,
        d.constructor_id,

        -- race context
        rc.season,
        rc.round,
        rc.race_name,
        rc.circuit_id,
        rc.race_date,
        rc.country                          as race_country,

        -- driver context
        d.driver_code,
        d.full_name                         as driver_name,
        d.nationality                       as driver_nationality,

        -- constructor context
        c.constructor_name,
        c.nationality                       as constructor_nationality,

        -- result metrics
        r.finish_position,
        r.grid_position,
        r.points,
        r.status,
        r.fastest_lap,
        r.laps_completed,

        -- flags
        r.finished_race,
        r.won_race,
        r.podium_finish,
        r.points_finish,

        -- position delta (gained/lost from grid)
        r.grid_position - r.finish_position as positions_gained

    from results       r
    inner join races        rc on r.race_id        = rc.race_id
    inner join drivers      d  on r.driver_id      = d.driver_id
    inner join constructors c  on d.constructor_id = c.constructor_id
)

select * from enriched

    
    
        limit 100
    
