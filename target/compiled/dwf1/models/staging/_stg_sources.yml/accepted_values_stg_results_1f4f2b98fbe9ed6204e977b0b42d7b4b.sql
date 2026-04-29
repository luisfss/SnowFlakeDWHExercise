
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from DWF1.dev_staging.stg_results
    group by status

)

select *
from all_values
where value_field not in (
    'Finished','DNF','DNS','Collision','Mechanical'
)


