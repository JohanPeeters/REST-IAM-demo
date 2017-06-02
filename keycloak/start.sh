#!/bin/sh

# Ad-hoc wrapper for off-the-shelf keycloak start scripts.

dockerize -wait tcp://${POSTGRES_PORT_5432_TCP_ADDR}:5432 -timeout 700s
/opt/jboss/docker-entrypoint.sh -b 0.0.0.0
