{{
    config(
        materialized="external",
        location="datalake/gold/file_by_process/file_by_process.parquet",
        format="parquet",
    )
}}

SELECT
    proc.pid,
    count(*) AS nb_files
FROM {{ ref("svr_dim_process") }} AS proc
LEFT JOIN {{ ref("svr_dim_file_reg") }} AS file
    ON
        proc.pid = file.pid
        AND proc.started_at <= file.started_at
GROUP BY proc.pid
