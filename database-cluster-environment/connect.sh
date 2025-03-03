#!/usr/bin/env bash

directory=$(dirname "$(realpath $0)")
c_directory=$(pwd)

export PGSSLMODE="verify-full"
export PGSSLROOTCERT="${directory}/generated/server.crt"
export PGPASSWORD=$(cat ${directory}/.postgrespass)

cd ${directory}
server=$(terraform output -json | jq -c -r .primary_ips.value[0])
cd ${c_directory}

psql -h ${server} "$@"