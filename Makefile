
# TAG?=latest
IMAGE_PREFIX:=kayuii
IMAGE_TAG:=hpool-miner

TARGET_IMAGE_PRD=$(IMAGE_PREFIX)/$(IMAGE_TAG)

all: hpool-miner xproxy

hpool-miner:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		cd "hpool/miner-v$${TRAVIS_TAG:13}/"; \
		docker buildx build --push --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD}:latest . ;\
	else \
		cd "hpool/miner-v$${TRAVIS_TAG:13}/"; \
		if [ ${TAG} -lt 120 ]; then \
			docker buildx build --push --platform "linux/amd64" -f Dockerfile -t ${TARGET_IMAGE_PRD}:$${TRAVIS_TAG:12} . ;\
		else
			docker buildx build --push --platform "linux/amd64,linux/arm64,linux/arm" -f Dockerfile -t ${TARGET_IMAGE_PRD}:$${TRAVIS_TAG:12} . ;\
		fi

	fi

xproxy:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
		echo "${TRAVIS_BRANCH}"; \
	else \
		echo "$${TRAVIS_TAG:8}"; \
		cd "x-proxy/xproxy-v$${TRAVIS_TAG:8}/"; \
		docker buildx build --push --platform "linux/amd64" -f Dockerfile -t ${TARGET_IMAGE_PRD}:$(TRAVIS_TAG) . ;\
	fi

.PHONY: xproxy hpool-miner
