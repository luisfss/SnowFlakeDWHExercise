
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select dim_constructor_sk
from DWF1.dev_marts.dim_constructors
where dim_constructor_sk is null



  
  
      
    ) dbt_internal_test