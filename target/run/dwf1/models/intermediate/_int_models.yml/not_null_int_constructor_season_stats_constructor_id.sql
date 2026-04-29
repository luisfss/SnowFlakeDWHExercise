
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select constructor_id
from DWF1.dev_intermediate.int_constructor_season_stats
where constructor_id is null



  
  
      
    ) dbt_internal_test