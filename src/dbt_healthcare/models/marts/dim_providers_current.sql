{{
  config(
    alias="dim_providers_current",
    materialized="table",
    tags=["silver", "scd2"],
  )
}}

select
  provider_id,
  npi,
  full_name,
  specialty,
  facility,
  status,
  dbt_valid_from as valid_from,
  dbt_valid_to as valid_to,
  dbt_scd_id
from {{ ref('snap_dim_providers') }}
where dbt_valid_to is null
