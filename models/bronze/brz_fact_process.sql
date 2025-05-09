{{
    config(
        materialized="external",
        location="datalake/bronze/fact_process/" ~ run_started_at.strftime("%Y-%m-%d") ~ ".parquet",
        format="parquet",
    )
}}

WITH raw_process AS (

    SELECT * FROM {{ source("raw", "fact_process") }}

)

SELECT
    *,
    CURRENT_TIMESTAMP AS ingested_at
FROM raw_process
