# Databricks notebook source
# MAGIC %md
# MAGIC # Load bronze CDC tables from landing volume (batch)
# MAGIC Reads Postgres-style CDC JSON and writes Delta bronze tables for dbt sources.

# COMMAND ----------

dbutils.widgets.text("catalog", "workspace")
dbutils.widgets.text("schema", "hc_dbt_bronze")
catalog = dbutils.widgets.get("catalog")
schema = dbutils.widgets.get("schema")

spark.sql(f"CREATE SCHEMA IF NOT EXISTS `{catalog}`.`{schema}`")
base = f"/Volumes/{catalog}/{schema}/cdc_landing"

entities = {
    "patients": "bronze_patients_cdc",
    "providers": "bronze_providers_cdc",
    "claims": "bronze_claims_cdc",
}

for folder, table in entities.items():
    path = f"{base}/{folder}"
    files = []
    try:
        files = [f.path for f in dbutils.fs.ls(path) if f.path.endswith(".json") or f.name.endswith(".json")]
    except Exception as e:
        raise RuntimeError(f"Landing path missing or empty: {path}. Run seed first. ({e})")

    df = spark.read.option("multiLine", "false").json(path)
    fq = f"`{catalog}`.`{schema}`.`{table}`"
    (
        df.write.format("delta")
        .mode("overwrite")
        .option("overwriteSchema", "true")
        .saveAsTable(fq)
    )
    print(f"Wrote {df.count()} rows -> {catalog}.{schema}.{table}")

display(spark.sql(f"SHOW TABLES IN `{catalog}`.`{schema}`"))
