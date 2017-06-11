.PHONY: test run build rm stop verify stop-postgres rm-postgres clean-run \
	persist-kc-config persist-config

include .env

define resolvesToLocal
	@echo Testing for $(1)
    @ping -q -c 1 -t 1 $(1) | grep -m 1 PING | cut -d "(" -f2 | cut -d ")" -f1 | grep -q 127.0.0.1
endef

define import_file
	export PGPASSWORD='$(3)' && psql -h localhost -p 3333 -U $(2) -d postgres < $(1)
endef

verify:
	$(info Testing of necessary name resolutions using hostfile for local testing)
	$(call resolvesToLocal,softwarewolves.org)

stop:
	@docker-compose stop

spa:
	@cd client && webpack && webpack-dev-server

rm: stop
	@docker-compose rm -f

stop-postgres:
	-@docker stop $(POSTGRES_NAME)

rm-postgres: stop-postgres
	-@docker rm $(POSTGRES_NAME)

build:
	@docker-compose build

run:
	@docker-compose up -d

clean-run: rm-postgres
	-@docker volume rm restiamdemo_pg_data
	@docker-compose up -d --build
	@make spa

persist-kc-config:
	@echo "\c ${KC_DB}" > ./initdb/keycloak.sql
	@docker container exec ${POSTGRES_NAME} \
	 pg_dump --clean --if-exists --create --inserts -U $(KC_DB_OWNER) $(KC_DB) >> ./initdb/keycloak.sql

persist-config: persist-kc-config

node_modules: package.json
	@yarn install

test: node_modules
	@npm test

aws-db-init:
	$(info Initialises the database)
	@@ssh -f -o ExitOnForwardFailure=yes -L 3333:keycloak.c7y3d9msb0fs.eu-west-1.rds.amazonaws.com:5432 ec2-user@ec2-52-31-176-41.eu-west-1.compute.amazonaws.com sleep 10
	$(call import_file,./initdb/keycloak.sql,$(KC_DB_OWNER),$(KC_DB_OWNER_PWD))
