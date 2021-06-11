
# TAG?=latest
IMAGE_PREFIX:=kayuii
IMAGE_TAG:=hpool-miner

TARGET_IMAGE_PRD=$(IMAGE_PREFIX)/$(IMAGE_TAG)

TAGPRE=$(shell echo "${TRAVIS_TAG}" | cut -c9-13)
TAGHPOOL=$(shell echo "${TRAVIS_TAG}" | cut -c12-18)

all: hpool-miner xproxy

hpool-miner:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		cd "hpool/miner-${TAGHPOOL}/"; \
		docker buildx build --push --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD}:latest . ;\
	else \
		cd "hpool/miner-${TAGHPOOL}/"; \
		if [ ${TAG} -lt 120 ]; then \
			docker buildx build --push --platform "linux/amd64" -f Dockerfile -t ${TARGET_IMAGE_PRD}:${TAGHPOOL} . ;\
		else
			docker buildx build --push --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD}:${TAGHPOOL} . ;\
		fi \
	fi

xproxy:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		echo "${TRAVIS_BRANCH}"; \
	else \
		cd "x-proxy/xproxy-v${TAGPRE}/"; \
		docker buildx build --push --platform "linux/amd64" -f Dockerfile -t ${TARGET_IMAGE_PRD}:$(TRAVIS_TAG) . ;\
	fi

.PHONY: xproxy hpool-miner
