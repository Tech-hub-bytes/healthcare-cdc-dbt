{{ config(alias="stg_patients_current") }}

-- Latest non-delete patient state (feed for SCD2 snapshot)
with ranked as (
  select
    *,
    row_number() over (partition by patient_id order by event_ts desc) as rn
  from {{ ref('stg_patients_cdc') }}
)

select
  patient_id,
  first_name,
  last_name,
  gender,
  zip_code,
  insurance_plan,
  status,
  event_ts
from ranked
where rn = 1
  and op <> 'd'
