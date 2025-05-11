{{
    config(
        materialized="external",
        location="datalake/silver/fact_process/fact_process.parquet",
        format="parquet",
    )
}}


SELECT
    fact.pid::INT AS pid,
    fact.started_at,
    fact.created_at,
    fact.pcpu::FLOAT AS pcpu,
    fact.pmem::FLOAT AS pmem,
    fact.ingested_at,
    com.command
FROM {{ source("bronze", "fact_process") }} AS fact
LEFT JOIN {{ ref("proc_commands") }} AS com
    ON fact.pid = com.pid
