/*
  int_constructor_season_stats
  ----------------------------
  Aggregates per-constructor (team) season statistics by summing
  across both drivers. Builds on stg_results directly rather than
  on int_driver_season_stats to avoid double-counting.
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

joined as (
    select
        d.constructor_id,
        c.constructor_name,
        c.nationality,
        rc.season,

        count(distinct r.driver_id)                                     as drivers_used,
        sum(r.points)                                                   as total_points,
        sum(case when r.won_race      then 1 else 0 end)                as wins,
        sum(case when r.podium_finish then 1 else 0 end)                as podiums,
        sum(case when r.fastest_lap   then 1 else 0 end)                as fastest_laps,

        round(
            sum(case when r.finished_race then 1 else 0 end)::float
            / nullif(count(*), 0) * 100,
            1
        )                                                               as finish_rate_pct

    from results       r
    inner join races   rc on r.race_id        = rc.race_id
    inner join drivers d  on r.driver_id      = d.driver_id
    inner join constructors c on d.constructor_id = c.constructor_id
    group by 1, 2, 3, 4
),

ranked as (
    select
        *,
        row_number() over (
            partition by season
            order by total_points desc, wins desc
        ) as championship_position
    from joined
)

select * from ranked