/*
  assert_points_not_negative
  --------------------------
  Singular test: ensures no result row carries negative points.
  dbt tests pass when the query returns zero rows.
*/

select
    result_id,
    driver_id,
    race_id,
    points
from DWF1.dev_staging.stg_results
where points < 0