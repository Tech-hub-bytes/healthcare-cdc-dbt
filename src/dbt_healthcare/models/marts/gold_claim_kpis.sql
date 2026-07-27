{{
  config(
    alias="gold_claim_kpis",
    materialized="table",
    tags=["gold"],
  )
}}

select
  claim_status,
  count(*) as claim_count,
  round(sum(billed_amount), 2) as total_billed,
  round(sum(paid_amount), 2) as total_paid,
  round(avg(billed_amount), 2) as avg_billed
from {{ ref('fct_claims') }}
group by claim_status
