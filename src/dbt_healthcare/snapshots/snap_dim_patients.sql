{% snapshot snap_dim_patients %}
{{
  config(
    unique_key="patient_id",
    strategy="timestamp",
    updated_at="event_ts",
    invalidate_hard_deletes=True,
    tags=["scd2", "patients"],
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
  event_ts
from {{ ref("stg_patients_current") }}

{% endsnapshot %}
