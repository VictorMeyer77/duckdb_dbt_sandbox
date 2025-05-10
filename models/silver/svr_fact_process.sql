{{
    config(
        materialized="external",
        location="datalake/bronze/fact_process/fact_process.parquet",
        format="parquet",
    )
}}

WITH bronze_process AS (

    SELECT * FROM {{ source("bronze", "fact_process") }}

)

SELECT
    pid::INT AS pid,
    started_at,
    created_at,
    pcpu::FLOAT AS pcpu,
    pmem::FLOAT AS pmem,
    ingested_at
FROM bronze_process
