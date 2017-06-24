# README #

This repository aims to build, run and test the target Docker images: iam-service/keycloak, iam-service/apiman, iam-service/test-service and postgres locally. Its Makefile makes this very easy, as well as deploying these artefacts to AWS.

## What should your hosts file look like ##
#SPAConference
127.0.0.1	keycloak.com
127.0.0.1	spaclient.org
127.0.0.1	spaidsrv.org
127.0.0.1	productapi.org
127.0.0.1	invoiceapi.org

## What is this repository for? ##

This repo contains
* docker-compose.yml: intended to bring up all the containers in the IAM project
* Makefile: to build and run the IAM target containers
* README.md: this file
* test: a directory for the acceptance tests
* package.json: defines the dependencies for the acceptance tests.

## How do I get set up? ##

In order to build and run the system locally, or to be able to deploy to AWS, you also need to install the following:
* Docker
* make
* Java 8
* jq
* ssh

For reasons explained further below, you need to make sure that the `/etc/hosts` file resolves to `localhost` for `softwarewolves.org`. An easy way to do so is to run the following command

    sudo sh -c "echo '127.0.0.1    softwarewolves.org' >> /etc/hosts"    

For the first run, you call `make clean-run`. This
* builds the test service
* downloads base Docker images for apiman, KeyCloak and the test service
* builds new apiman, KeyCloak and test service Docker images
* starts up containers using these images, as well as a PostgreSQL container.

All this takes quite some time - perhaps half an hour or so. Fortunately, subsequent runs will not take quite so long since Docker images have been downloaded and built. In fact, after the first run, you will usually do `make run` to start the containers, with a typical start-up time of a couple of minutes.

In order to run the tests, you need Node. Also recommended are
* Postman
* PostgreSQL (actually the psql client is all you need, but it is probably easier to install the entire RDBMS)

Sometimes you may want to start services individually in an otherwise functioning configuration. You can do so with the command `docker-compose up <service name>`. If you want to override the default entrypoint, you can use `docker-compose run --entrypoint <cmd> <service>`. For example, starting the KeyCloak docker container without the KeyCloak server can be done with `docker-compose run --entrypoint bash keycloak`.

If you want to change the KeyCloak initial configuration, you can do so by starting a pristine system with `make run`, making the desired configuration changes in the KeyCloak administrative console and then executing `make persist-kc-config`. The configuration is currently in `initdb/keycloak.sql`. Persisting the configuration can also be done with the  command `make persist-config`.

## Contribution guidelines ##

Do not commit code unless it passes the e2e tests. Except for `README.md` and `.gitignore`, everything in the repo is considered as code.

## Writing tests ##

End-to-end acceptance tests for the IAM project are written in Chakram. See the `test` directory.

## Who do I talk to? ##

* Repo owner or admin: yo@johanpeeters.com
* Other community or team contact
