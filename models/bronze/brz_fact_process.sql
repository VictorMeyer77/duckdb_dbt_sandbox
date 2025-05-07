{{
    config(materialized="external",
    location="datalake/bronze/brz_fact_process.parquet")
}}

with raw_process as (

    select * from {{ source("raw_fact_process", "brz_fact_process") }}

)

select * from raw_process
