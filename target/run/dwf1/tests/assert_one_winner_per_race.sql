
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  /*
  assert_one_winner_per_race
  --------------------------
  Singular test: each race must have exactly one driver with won_race = true.
  Returns any race that violates this constraint.
*/

with winners_per_race as (
    select
        race_id,
        count(*) as winner_count
    from DWF1.dev_staging.stg_results
    where won_race = true
    group by race_id
)

select *
from winners_per_race
where winner_count != 1
  
  
      
    ) dbt_internal_test