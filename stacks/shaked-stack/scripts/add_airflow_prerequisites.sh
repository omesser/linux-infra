set -euo pipefail

log() {
    sudo echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" 
}

error_exit() {
    log "ERROR: $1"
    exit 1
}

create_folder_structure() {
    mkdir -p /home/prisma/config || error_exit "Failed to create folder /home/prisma/config"
    mkdir -p /home/prisma/coordinates || error_exit "Failed to create folder /home/prisma/coordinates"
}

copy_files() {
    cp -r /home/prisma/"$OFFLINE_DEPLOY"/shaked/config/* /home/prisma/config/ || error_exit "Failed to copy contents from /home/prisma/$OFFLINE_DEPLOY/shaked/config to /home/prisma/config"
    cp -r /home/prisma/"$OFFLINE_DEPLOY"/shaked/coordinates/* /home/prisma/coordinates/ || error_exit "Failed to copy contents from /home/prisma/$OFFLINE_DEPLOY/shaked/coordinates to /home/prisma/coordinates"
}

add_secrets() {
    kubectl create secret generic shaked-onprem-secret \
        --from-literal=db_host="postgres" \
        --from-literal=db_username="postgres" \
        --from-literal=db_password="postrgres" \
        -n airflow || error_exit "Failed to create secret shaked-onprem-secret in namespace airflow"
}

add_pvs() {
    kubectl apply -f ../airflow/pvs.yml || error_exit "Failed to apply persistent volumes from ../airflow/pvs.yml"
}

create_folder_structure
copy_files
add_secrets
add_pvs