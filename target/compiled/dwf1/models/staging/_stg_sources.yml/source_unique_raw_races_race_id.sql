
    
    

select
    race_id as unique_field,
    count(*) as n_records

from DWF1.dev_raw.races
where race_id is not null
group by race_id
having count(*) > 1


