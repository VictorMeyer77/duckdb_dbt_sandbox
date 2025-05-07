{{
    config(
        materialized="external",
        location="datalake/bronze/fact_process/" ~ run_started_at.strftime("%Y-%m-%d") ~ ".parquet",
        format="parquet",
    )
}}

WITH raw_process AS (

    select * from {{ source("raw", "fact_process") }}

)

SELECT * FROM raw_process
