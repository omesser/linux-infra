#!/bin/bash

# Enable strict error handling
set -euo pipefail

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Error exit function
error_exit() {
    log "ERROR: $1"
    exit 1
}

wait_for_pod_readiness() {
  log "Waiting for pod with label release=kibana to be ready..."
  if ! kubectl wait --for=condition=ready pod -l "app.kubernetes.io/instance=postgresql-dev" -n posgtres-shaked --timeout=180s; then
      error_exit "Pod with label release=kibana failed to become ready within 180s"
  fi
}

init_db() {
  HOST="$THREE_FIRST_OCTETS.104"
  PORT="5672"
  DB="postgres"
  USER="postgres"
  PASSWORD="postgres"
  SQL_FILE="./postgres/database_script.sql"
  DATA_SCRIPT="./postgres/data_script.sql"

  # Check if the SQL file exists
  if [[ ! -f "$SQL_FILE" ]]; then
      error_exit "SQL file $SQL_FILE not found."
  fi

  # Check if the SQL script has already been run by verifying a known table exists
  log "Checking if SQL script has already been executed (looking for table prisma_projects.customers)..."
  RESULT=$(PGPASSWORD="$PASSWORD" psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB" -t -c "SELECT to_regclass('prisma_projects.customers');") || error_exit "Failed to query PostgreSQL."
  RESULT=$(echo "$RESULT" | xargs)  # trim whitespace

  if [[ -z "$RESULT" || "$RESULT" == "NULL" ]]; then
      log "SQL script not run. Executing $SQL_FILE..."
      PGPASSWORD="$PASSWORD" psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB" -f "$SQL_FILE" || error_exit "Failed to execute SQL script."
      log "SQL script executed successfully."
  else
      log "SQL script already executed. Skipping execution."
  fi

  log "Checking if data has already been inserted (looking for customer with id=17)..."
  DATA_CHECK=$(PGPASSWORD="$PG_PASSWORD" psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DB" -t -c "SELECT count(*) FROM prisma_projects.customers WHERE id = 17;") \
      || error_exit "Failed to query PostgreSQL for data."
  DATA_CHECK=$(echo "$DATA_CHECK" | xargs)  # trim whitespace

  if [[ "$DATA_CHECK" -eq 0 ]]; then
      log "Data not found. Executing $DATA_SCRIPT..."
      PGPASSWORD="$PG_PASSWORD" psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DB" -f "$DATA_SCRIPT" \
          || error_exit "Failed to execute data script."
      log "Data script executed successfully."
  else
      log "Data already exists. Skipping execution of $DATA_SCRIPT."
  fi
}

wait_for_pod_readiness
init_db
