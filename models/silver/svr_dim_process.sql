{{
    config(
        materialized="external",
        location="datalake/silver/dim_process/dim_process.parquet",
        format="parquet"
    )
}}

SELECT
    pid::INT AS pid,
    started_at,
    ingested_at
FROM {{ ref("brz_dim_process") }}
