{{
    config(
        materialized="external",
        location="datalake/bronze/dim_process/dim_process.parquet",
        format="parquet"
    )
}}

WITH ranked_processes AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY pid ORDER BY started_at ASC) AS rank
    FROM {{ ref("brz_fact_process") }}
)

SELECT
    pid,
    started_at
FROM ranked_processes WHERE rank = 1
