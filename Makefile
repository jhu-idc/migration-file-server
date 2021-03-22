DOCKER_REGISTRY=ghcr.io/jhu-sheridan-libraries/idc-isle-dc
CONTAINER_NAME=migration-assets

.PHONY: image
image: .make/image

.make/image:
	docker build -t ${DOCKER_REGISTRY}/${CONTAINER_NAME} .

.PHONY: push
push: .make/push

.make/push:
	docker push ${DOCKER_REGISTRY}/${CONTAINER_NAME}

.PHONY: help
help:
	@echo "Migration file server supported make targets are:"
	@echo "  image: (default) builds the Docker image used for tests"
	@echo "  push: pushes the image to the GHCR"

