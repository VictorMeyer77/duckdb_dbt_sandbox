{{
    config(
        materialized="external",
        location="datalake/gold/file_by_process/file_by_process.parquet",
        format="parquet",
    )
}}

SELECT
    pro.pid,
    count(*) AS nb_files
FROM {{ ref("svr_dim_process") }} AS pro
LEFT JOIN {{ ref("svr_dim_file_reg") }} AS file_reg
    ON
        pro.pid = file_reg.pid
        AND pro.started_at <= file_reg.started_at
GROUP BY pro.pid
