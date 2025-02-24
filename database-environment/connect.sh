#!/usr/bin/env bash

export PGSSLMODE="verify-full"
export PGSSLROOTCERT="generated/server.crt"

psql "$@"