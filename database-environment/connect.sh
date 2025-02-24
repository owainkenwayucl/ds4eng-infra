#!/usr/bin/env bash

export PGSSLMODE="verify-full"
export PGSSLROOTCERT="generated/server.crt"
server=$(terraform output -json | jq -c -r .vm_ips.value[0])

psql -h ${server} "$@"