#!/bin/bash

openssl req -x509 -newkey rsa:4096 -keyout /var/lib/pgsql/data/server.key -out /var/lib/pgsql/data/server.crt -sha256 -days 3650 -nodes -subj "/CN=${1}" -addext "subjectAltName = IP:${1}"