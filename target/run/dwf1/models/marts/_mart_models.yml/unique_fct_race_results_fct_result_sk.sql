
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    fct_result_sk as unique_field,
    count(*) as n_records

from DWF1.dev_marts.fct_race_results
where fct_result_sk is not null
group by fct_result_sk
having count(*) > 1



  
  
      
    ) dbt_internal_test