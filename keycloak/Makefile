.phony: build run


NAMESPACE := iam-service
NAME := keycloak
VERSION := latest

TAG := $(NAMESPACE)/$(NAME):$(VERSION)

build:
	@docker build -t $(TAG) .

run: build
	@docker run --name $(NAME) --rm -it -p 8443:8443 $(TAG)
