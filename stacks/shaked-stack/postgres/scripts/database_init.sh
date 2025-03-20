#!/bin/bash

# PostgreSQL connection details
PG_HOST="172.31.7.72"          # Change to your PostgreSQL host (or Kubernetes service name)
PG_PORT="5432"               # Default PostgreSQL port
PG_USER="shaked"             # PostgreSQL username
PG_PASSWORD="shaked@2025"  # PostgreSQL password
PG_DB="postgres"        # Target database

# Export password so psql doesn't prompt for it
export PGPASSWORD=$PG_PASSWORD

# Execute SQL script
echo "Executing SQL setup..."
psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB -f "src/database/database_script.sql"
psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB -f "src/database/data_script.sql"

# Check execution result
if [ $? -eq 0 ]; then
    echo "SQL script executed successfully!"
else
    echo "Error executing SQL script."
fi