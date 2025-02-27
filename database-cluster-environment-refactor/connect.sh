#!/usr/bin/env bash

directory=$(dirname "$(realpath $0)")
c_directory=$(pwd)

export PGSSLMODE="verify-full"
export PGPASSWORD=$(cat ${directory}/.postgrespass)

cd ${directory}
server=$(terraform output -json | jq -c -r .primary_ips.value[0])
cd ${c_directory}
export PGSSLROOTCERT="${directory}/generated/${server}_server.crt"

psql -h ${server} "$@"