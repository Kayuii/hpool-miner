FROM ubuntu:20.04

RUN groupadd -r chia && useradd -r -m -g chia chia
ENV PATH=$PATH:/opt
WORKDIR /opt

COPY --from=builder /opt/x-proxy-og-linux-amd64 /opt/x-proxy
COPY --from=builder /opt/config.yaml /opt/config.yaml

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl gosu sqlite3 \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && cd /opt/ \
    && curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini \
    && chmod +x tini \
    && ls -al /opt/ \
    && rm /opt/config.yaml

EXPOSE 9190

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["x-proxy"]
