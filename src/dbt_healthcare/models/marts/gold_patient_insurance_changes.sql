{{
  config(
    alias="gold_patient_insurance_changes",
    materialized="table",
    tags=["gold", "scd2"],
  )
}}

select
  patient_id,
  insurance_plan,
  zip_code,
  dbt_valid_from as valid_from,
  dbt_valid_to as valid_to,
  case when dbt_valid_to is null then true else false end as is_current
from {{ ref('snap_dim_patients') }}
