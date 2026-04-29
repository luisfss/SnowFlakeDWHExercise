
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select result_id
from DWF1.dev_marts.fct_race_results
where result_id is null



  
  
      
    ) dbt_internal_test