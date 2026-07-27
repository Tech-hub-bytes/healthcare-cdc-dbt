{{
  config(
    alias="fct_claims",
    materialized="incremental",
    unique_key="claim_id",
    incremental_strategy="merge",
    tags=["silver", "facts"],
  )
}}

-- Full current claim set merged each run (SCD Type 1)
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
  event_ts as updated_at
from {{ ref('int_claims_latest') }}
