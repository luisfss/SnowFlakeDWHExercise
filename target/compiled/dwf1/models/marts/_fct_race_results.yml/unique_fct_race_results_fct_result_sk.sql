
    
    

select
    fct_result_sk as unique_field,
    count(*) as n_records

from DWF1.dev_marts.fct_race_results
where fct_result_sk is not null
group by fct_result_sk
having count(*) > 1


