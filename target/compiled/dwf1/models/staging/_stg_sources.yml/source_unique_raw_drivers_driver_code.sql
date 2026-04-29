
    
    

select
    driver_code as unique_field,
    count(*) as n_records

from DWF1.dev_raw.drivers
where driver_code is not null
group by driver_code
having count(*) > 1


