PROM_VERSION=c448ada
AM_VERSION=4c6c03e
PRAM_VERSION=v0.2
DOCKER_IMAGE=tuandat825/pramtool:${PRAM_VERSION}

.DEFAULT_GOAL := build

.PHONY: build
build:
	docker build --build-arg prom_version=${PROM_VERSION} --build-arg am_version=${AM_VERSION} -t ${DOCKER_IMAGE} .

.PHONY: push
push: build
	docker push ${DOCKER_IMAGE} 