#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres \
     --set=kc_user="${KC_USER}" \
     --set=kc_password="${APIMAN_PASSWORD}"<<-EOSQL
    CREATE USER :kc_user WITH PASSWORD :'kc_password';
EOSQL
