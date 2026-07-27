{{ config(alias="stg_providers_cdc") }}

select
  lower(cast(op as string)) as op,
  cast(event_ts as timestamp) as event_ts,
  cast(provider_id as string) as provider_id,
  cast(npi as string) as npi,
  cast(full_name as string) as full_name,
  cast(specialty as string) as specialty,
  cast(facility as string) as facility,
  cast(status as string) as status
from {{ source('healthcare_bronze', 'bronze_providers_cdc') }}
where provider_id is not null
  and event_ts is not null
