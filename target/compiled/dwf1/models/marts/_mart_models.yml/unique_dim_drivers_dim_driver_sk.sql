
    
    

select
    dim_driver_sk as unique_field,
    count(*) as n_records

from DWF1.dev_marts.dim_drivers
where dim_driver_sk is not null
group by dim_driver_sk
having count(*) > 1


