
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select season
from DWF1.dev_raw.races
where season is null



  
  
      
    ) dbt_internal_test