{{ config(alias="stg_patients_cdc") }}

select
  lower(cast(op as string)) as op,
  cast(event_ts as timestamp) as event_ts,
  cast(patient_id as string) as patient_id,
  cast(first_name as string) as first_name,
  cast(last_name as string) as last_name,
  cast(gender as string) as gender,
  cast(zip_code as string) as zip_code,
  cast(insurance_plan as string) as insurance_plan,
  cast(status as string) as status
from {{ source('healthcare_bronze', 'bronze_patients_cdc') }}
where patient_id is not null
  and event_ts is not null
