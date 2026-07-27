# Healthcare CDC → dbt Lakehouse (standalone)

Separate Databricks Asset Bundle for an **end-to-end dbt** pipeline on healthcare CDC data.

Not part of `healthcare-cdc-scd-lakehouse` (that project keeps Lakeflow SDP Auto CDC).

## Pipeline

```text
Seed CDC JSON → Bronze Delta → dbt staging → SCD2 snapshots → facts → gold + tests
```

| Layer | Location |
|-------|----------|
| Landing | `/Volumes/workspace/hc_dbt_bronze/cdc_landing/` |
| Bronze | `workspace.hc_dbt_bronze.bronze_*_cdc` |
| dbt staging | `workspace.hc_dbt_staging` |
| SCD2 | `workspace.hc_dbt_snapshots` |
| Marts / gold | `workspace.hc_dbt_marts` |

## Deploy & run

```bash
cd C:\Users\Lenovo\Projects\healthcare-cdc-dbt
databricks bundle validate -t dev --profile dbc-7c3eed4c
databricks bundle deploy -t dev --profile dbc-7c3eed4c
databricks bundle run healthcare_dbt_e2e -t dev --profile dbc-7c3eed4c
```

## Query

```sql
SELECT * FROM workspace.hc_dbt_marts.gold_claim_kpis;
SELECT * FROM workspace.hc_dbt_marts.gold_patients_current;
SELECT * FROM workspace.hc_dbt_marts.gold_patient_insurance_changes;
```

## Related

- SDP Auto CDC lakehouse: https://github.com/Tech-hub-bytes/healthcare-cdc-scd-lakehouse
