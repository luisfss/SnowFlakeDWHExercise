
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    dim_constructor_sk as unique_field,
    count(*) as n_records

from DWF1.dev_marts.dim_constructors
where dim_constructor_sk is not null
group by dim_constructor_sk
having count(*) > 1



  
  
      
    ) dbt_internal_test