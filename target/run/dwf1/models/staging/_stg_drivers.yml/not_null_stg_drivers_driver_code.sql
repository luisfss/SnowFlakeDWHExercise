
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select driver_code
from DWF1.dev_staging.stg_drivers
where driver_code is null



  
  
      
    ) dbt_internal_test