
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select race_id
from DWF1.dev_raw.races
where race_id is null



  
  
      
    ) dbt_internal_test