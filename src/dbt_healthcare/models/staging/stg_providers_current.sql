{{ config(alias="stg_providers_current") }}

with ranked as (
  select
    *,
    row_number() over (partition by provider_id order by event_ts desc) as rn
  from {{ ref('stg_providers_cdc') }}
)

select
  provider_id,
  npi,
  full_name,
  specialty,
  facility,
  status,
  event_ts
from ranked
where rn = 1
  and op <> 'd'
