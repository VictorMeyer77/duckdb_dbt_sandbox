FROM python:3.12-slim

# Set working directory

WORKDIR /app

# install prerequistes

RUN apt-get update && \
    apt-get install -y build-essential

# Install environment

COPY requirements-dev.txt .
COPY requirements.in .
COPY Makefile .

RUN make install

# Copy dbt application

COPY profiles.yml .
COPY dbt_project.yml .
COPY analyses analyses
COPY datalake datalake
COPY macros macros
COPY models models
COPY seeds seeds
COPY snapshots snapshots
COPY tests tests

# Run

CMD ["make", "run"]
