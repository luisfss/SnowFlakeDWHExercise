
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select result_id
from DWF1.dev_intermediate.int_race_results_enriched
where result_id is null



  
  
      
    ) dbt_internal_test