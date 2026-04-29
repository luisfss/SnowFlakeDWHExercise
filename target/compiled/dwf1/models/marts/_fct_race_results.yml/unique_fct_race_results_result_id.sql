
    
    

select
    result_id as unique_field,
    count(*) as n_records

from DWF1.dev_marts.fct_race_results
where result_id is not null
group by result_id
having count(*) > 1


