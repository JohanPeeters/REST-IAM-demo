# README #

In this repository, we share REST access control experiments. It contains 2 Identity Providers (IdP), one using KeyCloak (`keycloak`), the other IdentityServer4 (`SpaIdSrv`). There are also 2 REST services, `InvoiceApi` and `ProductApi`, that require a JWT token signed by the respective IdPs prior to giving access. Finally, a JavaScript client, `SpaClient`, obtains these tokens and calls the APIs.

The first 4 components each run in their own Docker container, the latter is served by a Docker container and runs in a browser.

## How to use ##

### Prerequisites ###

In order to build and run the system locally, the following need to be installed:
* Docker
* make

and the `/etc/hosts` file should contain the following section:

    127.0.0.1	keycloak.com
    127.0.0.1	spaclient.org
    127.0.0.1	spaidsrv.org
    127.0.0.1	productapi.org
    127.0.0.1	invoiceapi.org

You will probably also want to install Postman.

### Running the demo locally ###

Execute `make run` in the repo root. This
* downloads base Docker images
* extends them
* starts up containers, as well as a PostgreSQL container used by KeyCloak to store its users and configuration.

All this takes quite some time - perhaps half an hour or so. Fortunately, subsequent runs do not take nearly so long since Docker images have been downloaded and built. Typically start-up time of subsequent runs is a couple of minutes.

Use `make clean-run` when pulling a new version.

### Things to try ###

* With Postman, security tokens can be retrieved from KeyCloak and IdentityServer with the requests in `REST-IAM demo (Local).postman_collection.json`.
* Browse to the SPA client running locally at http://spaclient.org:8080 and try calling the resource servers with and without logging into IdentityServer or KeyCloak.

## Repo structure ##

This repo contains
* docker-compose.yml: to bring up containers locally
* docker-compose_azure.yml: to bring up containers on Azure
* Makefile: to build and run the containers
* README.md: this file
* SpaIdSrv: STS built with IdentityServer4
* keycloak: KeyCloak customized
* initdb: KeyCloak configuration
* ProductApi: resource server
* InvoiceApi: resource server
* SpaClient: Single Page Application, client of the resource servers

## Contribution guidelines ##

If you want to contribute, we suggest you first create an issue so we can discuss your contribution.

## Troubleshooting ##

##### When connecting to the KeyCloak console, the browser issues a warning that the connection is insecure #####

Our bad. We were lazy and configured KeyCloak with a self-signed X.509 certificate. So, in this case, we recommend you 'click through' and connect to the site anyway. You may catch us preaching against such sloppy practices at other times, but there you are, for now, this will have to do.

##### Postman says it cannot connect to the local KeyCloak instance #####

Obviously, the first port of call is to check whether the KeyCloak container is running: `docker ps`. If so, you may need to configure Postman to accept self-signed certificates. Preferences -> Certificates.

##### After logging in with one of the IdPs, I get a blank page after the redirect to the SPA #####
This sometimes happens when the IdP issues tokens that have expired according to the clock of the client. This is arguably a bug - there should be a nice error message. Anyway, this happens because Docker Engine does not keep its clock in sync with the host, so after running Docker for a long time, it typically has drifted significantly. The solution is to restart Docker, restart the containers and try again.
