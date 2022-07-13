FROM ubuntu:20.04 as download

ARG TARGETARCH

COPY / /opt

RUN apt-get -qq update \
  && apt-get -qq install -y --no-install-recommends ca-certificates curl \
  && find /opt/ -name "*$TARGETARCH" | grep -v hpool-miner | xargs -i /bin/mv {} /opt/ \
  && cd /opt/ \
  && curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini-$TARGETARCH \
  && chmod +x tini* \
  && curl -sOL https://github.com/tianon/gosu/releases/download/1.14/gosu-$TARGETARCH \
  && chmod +x gosu*

FROM alpine:3.12 as timezone

Run apk update && apk add tzdata

FROM ubuntu:20.04

ENV PATH=$PATH:/opt

ENV TZ=Asia/Shanghai
WORKDIR /opt

COPY --from=timezone /usr/share/zoneinfo/$TZ /etc/localtime
COPY --from=download /opt/x-proxy-* /opt/x-proxy
COPY --from=download /opt/tini* /opt/tini
COPY --from=download /opt/gosu* /opt/gosu

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl sqlite3 \
    && groupadd -r chia \
    && useradd -r -m -g chia chia \
    && usermod -a -G users,chia chia \
    && echo $TZ > /etc/timezone \
    && ls -al /opt/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

EXPOSE 9190

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["x-proxy"]
