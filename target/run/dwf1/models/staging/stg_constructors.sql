
  create or replace   view DWF1.dev_staging.stg_constructors
  
  
  
  
  as (
    with source as (
    select * from DWF1.dev_raw.constructors
),

renamed as (
    select
        constructor_id,
        constructor_name,
        nationality,
        base_country
    from source
)

select * from renamed
  );

