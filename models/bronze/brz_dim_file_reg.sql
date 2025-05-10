{{
    config(
        materialized="external",
        location="datalake/bronze/dim_file_reg/dim_file_reg.parquet",
        format="parquet"
    )
}}

WITH ranked_files AS (
    SELECT
        *,
        ROW_NUMBER()
            OVER (PARTITION BY pid, fd, node ORDER BY created_at ASC)
        AS rank
    FROM {{ ref("brz_fact_file_reg") }}
)

SELECT
    pid,
    fd,
    node,
    created_at AS started_at,
    CURRENT_TIMESTAMP AS ingested_at
FROM ranked_files
WHERE rank = 1