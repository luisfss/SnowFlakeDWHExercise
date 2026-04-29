
  create or replace   view DWF1.dev_staging.stg_drivers
  
  
  
  
  as (
    with source as (
    select * from DWF1.dev_raw.drivers
),

renamed as (
    select
        driver_id,
        driver_code,
        forename,
        surname,
        forename || ' ' || surname   as full_name,
        nationality,
        date_of_birth::date          as date_of_birth,
        constructor_id
    from source
)

select * from renamed
  );

