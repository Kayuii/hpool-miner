FROM --platform=linux/amd64 alpine:3.12 as builder

ARG VER=v1.5.1-3
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

RUN groupadd -r chia && useradd -r -m -g chia chia && usermod -a -G users,chia chia

ENV PATH=$PATH:/opt
WORKDIR /opt

COPY --from=builder /etc/localtime /etc
COPY --from=builder /etc/timezone /etc
COPY --from=builder /opt/hpool-* /opt

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl gosu tini \
    && cd /opt/ \
    && mv hpool-* hpool-chia-miner \
    && ls -al /opt/

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["hpool-chia-miner"]
