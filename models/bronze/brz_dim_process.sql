{{
    config(materialized="external",
    location="datalake/bronze/brz_dim_process.parquet")
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
