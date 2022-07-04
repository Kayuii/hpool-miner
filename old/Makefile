
# TAG?=latest
IMAGE_PREFIX:=kayuii
IMAGE_OG:=hpool-miner
IMAGE_PP:=hpool-pp-miner

TARGET_IMAGE_PRD_OG=$(IMAGE_PREFIX)/$(IMAGE_OG)
TARGET_IMAGE_PRD_PP=$(IMAGE_PREFIX)/$(IMAGE_PP)

TAGPRE=$(shell echo "${TRAVIS_TAG}" | cut -c12-16)
TAGHPOOL=$(shell echo "${TRAVIS_TAG}" | cut -c16-23)
TAGHPOOL-PP=$(shell echo "${TRAVIS_TAG}" | cut -c16-23)

all: hpool-og-miner hpool-pp-miner xproxy-pp xproxy-og

hpool-og-miner:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		cd "hpool-og/miner-${TAGHPOOL}/"; \
		docker buildx build --push --progress "plain" --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD_OG}:latest . ;\
	else \
		cd "hpool-og/miner-${TAGHPOOL}/"; \
		docker buildx build --push --progress "plain" --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD_OG}:${TAGHPOOL} . ;\
	fi

hpool-pp-miner:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		cd "hpool-pp/miner-${TAGHPOOL-PP}/"; \
		docker buildx build --push --progress "plain" --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD_PP}:latest . ;\
	else \
		cd "hpool-pp/miner-${TAGHPOOL-PP}/"; \
		docker buildx build --push --progress "plain" --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD_PP}:${TAGHPOOL-PP} . ;\
	fi

xproxy-og:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		echo "${TRAVIS_BRANCH}"; \
	else \
		cd "x-proxy-og/xproxy-v${TAGPRE}/"; \
		docker buildx build --push --progress "plain" --platform "linux/amd64" -f Dockerfile -t ${TARGET_IMAGE_PRD_OG}:$(TRAVIS_TAG) . ;\
	fi

xproxy-pp:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		echo "${TRAVIS_BRANCH}"; \
	else \
		cd "x-proxy-pp/xproxy-v${TAGPRE}/"; \
		docker buildx build --push --progress "plain" --platform "linux/amd64" -f Dockerfile -t ${TARGET_IMAGE_PRD_PP}:$(TRAVIS_TAG) . ;\
	fi

.PHONY: hpool-og-miner hpool-pp-miner xproxy-pp xproxy-og
