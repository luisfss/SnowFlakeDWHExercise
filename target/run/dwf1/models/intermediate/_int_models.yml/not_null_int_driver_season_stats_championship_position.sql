
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select championship_position
from DWF1.dev_intermediate.int_driver_season_stats
where championship_position is null



  
  
      
    ) dbt_internal_test