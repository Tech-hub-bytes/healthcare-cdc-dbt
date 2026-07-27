{{
  config(
    alias="gold_claims_by_provider",
    materialized="table",
    tags=["gold"],
  )
}}

select
  p.provider_id,
  p.full_name,
  p.specialty,
  p.facility,
  count(*) as claim_count,
  round(sum(c.billed_amount), 2) as total_billed,
  round(sum(c.paid_amount), 2) as total_paid
from {{ ref('fct_claims') }} c
left join {{ ref('dim_providers_current') }} p
  on c.provider_id = p.provider_id
group by p.provider_id, p.full_name, p.specialty, p.facility
