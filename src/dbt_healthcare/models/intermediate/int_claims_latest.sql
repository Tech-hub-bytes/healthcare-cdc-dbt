{{
  config(
    alias="int_claims_latest",
    materialized="view",
  )
}}

-- Latest claim state per claim_id (SCD1 source); soft-deletes excluded
with ranked as (
  select
    *,
    row_number() over (partition by claim_id order by event_ts desc) as rn
  from {{ ref('stg_claims_cdc') }}
)

select
  claim_id,
  patient_id,
  provider_id,
  service_date,
  icd10_primary,
  cpt_primary,
  billed_amount,
  paid_amount,
  claim_status,
  event_ts
from ranked
where rn = 1
  and op <> 'd'
