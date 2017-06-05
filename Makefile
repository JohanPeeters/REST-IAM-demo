.PHONY: test run build rm stop verify stop-postgres rm-postgres clean-run \
	persist-kc-config persist-config

include .env

define resolvesToLocal
	@echo Testing for $(1)
    @ping -q -c 1 -t 1 $(1) | grep -m 1 PING | cut -d "(" -f2 | cut -d ")" -f1 | grep -q 127.0.0.1
endef

define import_file
	@export PGPASSWORD='$(3)' && psql -h localhost -p 3333 -U $(2) -d postgres < $(1)
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
	@make spa

clean-run: rm-postgres 	
	-@docker volume rm restiamdemonstrator_pg_data
	@docker-compose up -d --build  
	@make spa

persist-kc-config:
	@echo "\c ${KC_DB}" > ./initdb/keycloak.sql
	@docker container exec ${POSTGRES_NAME} \
	 pg_dump --clean --if-exists --create --inserts -U $(KC_DB_OWNER) $(KC_DB) >> ./initdb/keycloak.sql

persist-config: persist-kc-config

node_modules: package.json
	@npm install

test: node_modules
	@npm test
