FROM ubuntu:20.04 as download

COPY / /opt

RUN export ARCH=$(dpkg --print-architecture) \
  && if [ "$ARCH" = "amd64" ] ; then export ARCH=amd64; fi \
  && if [ "$ARCH" = "arm64" ] ; then export ARCH=aarch64; fi \
  && if [ "$ARCH" = "armhf" ] ; then export ARCH=arm; fi \
  && find /opt/ -name "*$ARCH" | grep -v xproxy | xargs -i /bin/mv {} /opt/

FROM alpine:3.12 as timezone

Run apk update && apk add tzdata

FROM ubuntu:20.04

ENV PATH=$PATH:/opt

ENV TZ=Asia/Shanghai
WORKDIR /opt

COPY --from=timezone /usr/share/zoneinfo/$TZ /etc/localtime
COPY --from=download /opt/hpool-* /opt/hpool-chia-miner

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl gosu tini \
    && groupadd -r chia \
    && useradd -r -m -g chia chia \
    && usermod -a -G users,chia chia \
    && echo $TZ > /etc/timezone \
    && ls -al /opt/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["hpool-chia-miner"]
