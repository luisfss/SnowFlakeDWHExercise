with source as (
    select * from {{ source('raw', 'constructors') }}
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
