set -euo pipefail

log() {
    sudo echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" 
}

error_exit() {
    log "ERROR: $1"
    exit 1
}

ensure_directory() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        log "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

create_folder_structure() {
    ensure_directory /home/prisma/shaked/config || error_exit "Failed to create folder /home/prisma/shaked/config"
    ensure_directory /home/prisma/shaked/coordinates || error_exit "Failed to create folder /home/prisma/shaked/coordinates"
}

copy_files() {
    cp -r /home/prisma/"$OFFLINE_DEPLOY"/shaked/config/* /home/prisma/shaked/config/ || error_exit "Failed to copy contents from /home/prisma/$OFFLINE_DEPLOY/shaked/config to /home/prisma/shaked/config"
    cp -r /home/prisma/"$OFFLINE_DEPLOY"/shaked/coordinates/* /home/prisma/shaked/coordinates/ || error_exit "Failed to copy contents from /home/prisma/$OFFLINE_DEPLOY/shaked/coordinates to /home/prisma/shaked/coordinates"
}

add_pvs() {
    kubectl apply -f airflow/pvs.yml || error_exit "Failed to apply persistent volumes from airflow/pvs.yml"
}

add_secrets() {
    if kubectl get secret shaked-onprem-secret -n airflow >/dev/null 2>&1; then
        log "Secret 'shaked-onprem-secret' already exists in namespace 'airflow'. Skipping creation."
    else
        kubectl create secret generic shaked-onprem-secret \
            --from-literal=db_host="postgres-shaked-postgresql.postgres-shaked.svc.cluster.local" \
            --from-literal=db_username="postgres" \
            --from-literal=db_password="postrgres" \
            -n airflow || error_exit "Failed to create secret 'shaked-onprem-secret' in namespace 'airflow'"
        log "Secret 'shaked-onprem-secret' created successfully."
    fi
}

create_folder_structure
copy_files
add_pvs
add_secrets