{{
    config(
        materialized="external",
        location="datalake/silver/fact_file_reg/fact_file_reg.parquet",
        format="parquet",
    )
}}

WITH bronze_file_reg AS (

    SELECT * FROM {{ source("bronze", "fact_file_reg") }}

)

SELECT DISTINCT
    pid::INT AS pid,
    fd::STRING AS fd,
    node::INT AS node,
    created_at,
    size::INT AS size,
    ingested_at
FROM bronze_file_reg
