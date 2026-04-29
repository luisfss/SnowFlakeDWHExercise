
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select points
from DWF1.dev_staging.stg_results
where points is null



  
  
      
    ) dbt_internal_test