
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select fct_result_sk
from DWF1.dev_marts.fct_race_results
where fct_result_sk is null



  
  
      
    ) dbt_internal_test