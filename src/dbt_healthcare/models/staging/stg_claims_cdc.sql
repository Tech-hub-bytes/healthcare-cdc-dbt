{{ config(alias="stg_claims_cdc") }}

select
  lower(cast(op as string)) as op,
  cast(event_ts as timestamp) as event_ts,
  cast(claim_id as string) as claim_id,
  cast(patient_id as string) as patient_id,
  cast(provider_id as string) as provider_id,
  cast(service_date as date) as service_date,
  cast(icd10_primary as string) as icd10_primary,
  cast(cpt_primary as string) as cpt_primary,
  cast(billed_amount as double) as billed_amount,
  cast(paid_amount as double) as paid_amount,
  cast(claim_status as string) as claim_status
from {{ source('healthcare_bronze', 'bronze_claims_cdc') }}
where claim_id is not null
  and event_ts is not null
