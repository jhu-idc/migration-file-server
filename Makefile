DOCKER_REGISTRY=ghcr.io/jhu-sheridan-libraries/idc-isle-dc
CONTAINER_NAME=migration-assets

.PHONY: image
image: .make/init .make/image

.make/image:
	docker build -t ${DOCKER_REGISTRY}/${CONTAINER_NAME}:$(shell cat .make/init.gitrev).$(shell cat .make/init.date) .
	@touch .make/image

.PHONY: init
init: .make/init

.make/init:
	$(shell date +%s > .make/init.date)
	$(shell git rev-parse --short HEAD > .make/init.gitrev)
	@touch .make/init

.PHONY: push
push: .make/init .make/image .make/push

.make/push:
	docker push ${DOCKER_REGISTRY}/${CONTAINER_NAME}:$(shell cat .make/init.gitrev).$(shell cat .make/init.date)

.PHONY: clean
clean:
	@rm .make/*

.PHONY: help
help:
	@echo "Migration file server supported make targets are:"
	@echo "  image: (default) builds the Docker image used for tests"
	@echo "  push: pushes the image to the GHCR"
	@echo "  clean: removes 'make' state"

