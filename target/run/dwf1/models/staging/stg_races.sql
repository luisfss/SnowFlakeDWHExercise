
  create or replace   view DWF1.dev_staging.stg_races
  
  
  
  
  as (
    with source as (
    select * from DWF1.dev_raw.races
),

renamed as (
    select
        race_id,
        season,
        round,
        circuit_id,
        race_name,
        race_date::date          as race_date,
        country
    from source
)

select * from renamed
  );

