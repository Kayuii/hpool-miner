FROM --platform=linux/amd64 alpine:3.12 as builder

ARG VER=1.5.8
ARG TARGETARCH
ARG ARCH
ENV PATH=$PATH:/opt
ENV TZ=Asia/Shanghai

COPY arch.sh /tmp/arch.sh

 RUN apk --no-cache add bash tzdata \
 && mkdir -p /tmp/linux \
 && /tmp/arch.sh ${VER} \
 && mv /tmp/linux/* /opt/ \
 && cp /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone \
 && cat /etc/timezone \
 && rm -rf /tmp/* \
 && apk del tzdata

FROM ubuntu:20.04

RUN groupadd -r chia && useradd -r -m -g chia chia
ENV PATH=$PATH:/opt
WORKDIR /opt

COPY --from=builder /etc/localtime /etc
COPY --from=builder /etc/timezone /etc
COPY --from=builder /opt/x-proxy-og-linux-amd64 /opt/x-proxy
COPY --from=builder /opt/config.yaml /opt/config.yaml

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl gosu sqlite3 \
    && cd /opt/ \
    && curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini \
    && chmod +x tini \
    && ls -al /opt/ \
    && rm /opt/config.yaml

EXPOSE 9190

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["x-proxy"]
