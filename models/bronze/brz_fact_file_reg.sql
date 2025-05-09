{{
    config(
        materialized="external",
        location="datalake/bronze/fact_file_reg/" ~ run_started_at.strftime("%Y-%m-%d") ~ ".parquet",
        format="parquet",
    )
}}

WITH raw_file_reg AS (

    SELECT * FROM {{ source("raw", "fact_file_reg") }}

)

SELECT
    *,
    CURRENT_TIMESTAMP AS ingested_at
FROM raw_file_reg
