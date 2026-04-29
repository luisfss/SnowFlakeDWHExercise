
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select driver_id
from DWF1.dev_raw.results
where driver_id is null



  
  
      
    ) dbt_internal_test