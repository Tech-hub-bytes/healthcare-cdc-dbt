{% snapshot snap_dim_providers %}
{{
  config(
    unique_key="provider_id",
    strategy="timestamp",
    updated_at="event_ts",
    invalidate_hard_deletes=True,
    tags=["scd2", "providers"],
  )
}}

select
  provider_id,
  npi,
  full_name,
  specialty,
  facility,
  status,
  event_ts
from {{ ref("stg_providers_current") }}

{% endsnapshot %}
