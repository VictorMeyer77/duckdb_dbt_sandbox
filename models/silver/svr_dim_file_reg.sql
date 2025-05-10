{{
    config(
        materialized="external",
        location="datalake/silver/dim_file_reg/dim_file_reg.parquet",
        format="parquet"
    )
}}

SELECT
    pid::INT AS pid,
    fd::STRING AS fd,
    node::INT AS node,
    started_at,
    ingested_at
FROM {{ ref("brz_dim_file_reg") }}
