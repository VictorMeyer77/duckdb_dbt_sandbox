.ONESHELL:
ENV_PREFIX=$(shell python -c "if __import__('pathlib').Path('.venv/bin/pip').exists(): print('.venv/bin/')")
.SHELLFLAGS := -e -c # exit if error

.PHONY: help
help:             ## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep


.PHONY: show
show:             ## Show the current environment.
	@echo "Current environment:"
	@echo "Running using $(ENV_PREFIX)"
	@$(ENV_PREFIX)python -V
	@$(ENV_PREFIX)python -m site

.PHONY: fmt
fmt:              ## Format sql files using sqlfluff
	@sqlfluff fix -f

.PHONY: lint
lint:             ## Run linter using sqlfluff
	@sqlfluff lint

.PHONY: install
install:          ## Install the project in dev mode.
	@echo "Don't forget to run 'make virtualenv' if you got errors."
	@./.venv/bin/pip install -r requirements-dev.txt
	@pip-compile requirements.in
	$(ENV_PREFIX)pip install -r requirements.txt

.PHONY: clean
clean:            ## Clean unused files.
	@dbt clean
	@rm -rf datalake/bronze/*/*.parquet
	@rm -rf datalake/silver/*/*.parquet
	@rm -rf datalake/gold/*/*.parquet
	@rm -rf test.duckdb
	@rm -rf __pycache__
	@rm -rf .cache
	@rm -rf .pytest_cache
	@rm -rf .mypy_cache
	@rm -rf build
	@rm -rf dist
	@rm -rf *.egg-info
	@rm -rf htmlcov
	@rm -rf .tox/
	@rm -rf docs/_build
	@rm -rf instance
	@rm -rf .coverage
	@rm -rf coverage.xml

.PHONY: virtualenv
virtualenv:       ## Create a virtual environment.
	@echo "creating virtualenv ..."
	@rm -rf .venv
	@python3 -m venv .venv
	@./.venv/bin/pip install -U pip
	@echo
	@echo "!!! Please run 'source .venv/bin/activate' to enable the environment !!!"


.PHONY: docs
docs:             ## Build the documentation.
	@echo "building documentation ..."
	@dbt docs generate
	@dbt docs serve

.PHONY: run
run:             ## Launch process.
	@rm -rf test.duckdb
	@echo "Process seeds"
	@dbt seed
	@echo "Execute and test bronze ..."
	@dbt run --select models/bronze
	@dbt test --select models/bronze
	@dbt run