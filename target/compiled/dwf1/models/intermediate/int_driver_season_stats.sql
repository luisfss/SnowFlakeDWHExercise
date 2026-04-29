/*
  int_driver_season_stats
  -----------------------
  Aggregates per-driver season statistics from race results.
  Joining to races here so we can group by season without carrying
  season through the results grain.

  Materialized as a table because it is a relatively expensive aggregation
  that multiple downstream marts will reference.
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
        r.driver_id,
        d.full_name,
        d.nationality,
        d.constructor_id,
        rc.season,
        d.driver_code,
        d.date_of_birth,
        c.constructor_name,

        -- volume
        count(distinct r.race_id)                                       as races_entered,
        sum(case when r.finished_race then 1 else 0 end)                as races_finished,

        -- performance
        sum(r.points)                                                   as total_points,
        sum(case when r.won_race        then 1 else 0 end)              as wins,
        sum(case when r.podium_finish   then 1 else 0 end)              as podiums,
        sum(case when r.points_finish   then 1 else 0 end)              as points_finishes,
        sum(case when r.fastest_lap     then 1 else 0 end)              as fastest_laps,

        -- reliability
        round(
            sum(case when r.finished_race then 1 else 0 end)::float
            / nullif(count(distinct r.race_id), 0) * 100,
            1
        )                                                               as finish_rate_pct,

        -- position averages (only counting classified finishes)
        round(avg(case when r.finished_race then r.finish_position end), 2) as avg_finish_position,
        round(avg(r.grid_position::float), 2)                           as avg_grid_position

    from results       r
    inner join races   rc on r.race_id   = rc.race_id
    inner join drivers d  on r.driver_id = d.driver_id
    inner join constructors c on d.constructor_id = c.constructor_id
    group by 1, 2, 3, 4, 5, 6, 7, 8
),

ranked as (
    select
        *,
        row_number() over (
            partition by season
            order by total_points desc, wins desc, podiums desc
        ) as championship_position
    from joined
)

select * from ranked