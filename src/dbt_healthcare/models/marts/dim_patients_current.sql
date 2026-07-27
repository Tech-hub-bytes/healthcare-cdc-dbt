{{
  config(
    alias="dim_patients_current",
    materialized="table",
    tags=["silver", "scd2"],
  )
}}

select
  patient_id,
  first_name,
  last_name,
  gender,
  zip_code,
  insurance_plan,
  status,
  dbt_valid_from as valid_from,
  dbt_valid_to as valid_to,
  dbt_scd_id
from {{ ref('snap_dim_patients') }}
where dbt_valid_to is null
