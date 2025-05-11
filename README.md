# duckdb_dbt_sandbox

Sandbox project for dbt with duckdb.

### Run locally

```shell
make virtualenv
source .venv/bin/activate
make install
make run
```

### Run with docker

```shell
docker build . -t duck_dbt_sx_image
docker run --mount type=bind,src=$(pwd)/datalake,dst=/app/datalake  duck_dbt_sx_image
```

More options with

```shell
make help
```
