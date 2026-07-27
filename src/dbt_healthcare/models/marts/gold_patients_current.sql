{{
  config(
    alias="gold_patients_current",
    materialized="table",
    tags=["gold"],
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
  valid_from
from {{ ref('dim_patients_current') }}
