with source as (
    select * from {{ source('raw', 'results') }}
),

renamed as (
    select
        result_id,
        race_id,
        driver_id,
        finish_position::int         as finish_position,
        grid_position::int           as grid_position,
        points::int                  as points,
        status,
        fastest_lap::boolean         as fastest_lap,
        laps_completed::int          as laps_completed,

        -- derived flags, cleaner to compute once here
        case when status = 'Finished'  then true else false end as finished_race,
        case when finish_position = 1  then true else false end as won_race,
        case when finish_position <= 3 then true else false end as podium_finish,
        case when finish_position <= 10
             and status = 'Finished'   then true else false end as points_finish
    from source
)

select * from renamed
