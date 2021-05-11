FROM alpine:3.12

ARG VER=v1.1.1
ENV PATH=$PATH:/opt
ENV TZ=Asia/Shanghai

RUN apk --no-cache add bash tzdata \
 && wget -q --no-check-certificate https://github.com/hpool-dev/chia-miner/releases/download/v1.1.1\(2\)/HPool-Miner-chia-v1.1.1-2.zip -O /tmp/chia-miner.zip && unzip /tmp/chia-miner.zip -d /tmp \
 && mv /tmp/linux/* /opt/ \
 && mv /opt/hpool-* /opt/hpool-chia-miner \
 && cp /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone \
 && cat /etc/timezone \
 && rm -rf /tmp/* \
 && apk del tzdata

WORKDIR /opt
