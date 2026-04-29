
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    driver_code as unique_field,
    count(*) as n_records

from DWF1.dev_staging.stg_drivers
where driver_code is not null
group by driver_code
having count(*) > 1



  
  
      
    ) dbt_internal_test