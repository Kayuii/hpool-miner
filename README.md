# [kayuii/hpool-miner](https://github.com/Kayuii/hpool-miner)

[![Build Status](https://travis-ci.com/Kayuii/hpool-miner.svg?branch=master)](https://travis-ci.com/Kayuii/hpool-miner)

An [hpool-chia-miner](https://github.com/hpool-dev/chia-miner) docker image.

## Tags

hpool-miner


update v1.2.0 Increase arm, aarch64 version

2021-06-11 add docker-entrypoint.sh, gosu, tini

- `v1.4.1-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.4.1-1/Dockerfile))
- `v1.4.0-2` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.4.0-2/Dockerfile))
- `v1.3.0-6` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.3.0-6/Dockerfile))
- `v1.3.0` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.3.0/Dockerfile))
- `v1.2.0-5` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.2.0-5/Dockerfile))
- `v1.2.0` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.2.0/Dockerfile))
- `v1.1.1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.1.1/Dockerfile))

## Examples

`docker-compose` example for hpool-miner:

```yml
version: "3"

services:
  miner:
    image: kayuii/hpool-miner:v1.4.1-1
    restart: always
    volumes:
      - /mnt/dst:/mnt/dst
      - /opt/chia/logs:/opt/log
      - /opt/chia/config.yaml:/opt/config.yaml
    command:
      - hpool-chia-miner
```
or
```yml
version: "3"

services:
  miner:
    image: kayuii/hpool-miner:v1.4.1-1
    restart: always
    volumes:
      - /mnt/dst:/mnt/dst
      - /opt/chia/logs:/opt/log
    environment:
      - DIR=["/mnt/dst"]
      - APIKEY=1df8e525-772f-40e9-908d-0f26e36f8046
      - HOSTNAME=miner
      - LOGPATH=./logs/
      - SCAN=30
      - PROXY=http://192.168.1.88:9190
    command:
      - hpool-chia-miner
```

command-line example:

```sh
docker run -itd --rm  --name miner \
    -v "/mnt/dst:/mnt/dst" \
    -v "/opt/chia/logs:/opt/log" \
    -v "/opt/chia/config.yaml:/opt/config.yaml" \
    kayuii/hpool-miner:v1.4.1-1 hpool-chia-miner
```
or
```sh
docker run -itd --rm  --name miner \
    -v "/mnt/dst:/mnt/dst" \
    -v "/opt/chia/logs:/opt/log" \
    -e 'DIR=["/mnt/dst"]'
    -e "APIKEY=1df8e525-772f-40e9-908d-0f26e36f8046"
    -e 'HOSTNAME=miner'
    -e 'LOGPATH=./logs/'
    -e 'SCAN=30'
    -e 'PROXY=http://192.168.1.88:9190'
    kayuii/hpool-miner:v1.4.1-1 hpool-chia-miner
```

default config.yaml

```yaml
path:            #扫盘路径
minerName:          #矿机名称（自定义）
apiKey:             #hpool apikey
cachePath: ""
deviceId: ""
extraParams: {}
log:
  lv: info
  path: ./log/
  name: miner.log
url:
  # 一个局域网内，代理只需要开一台就可以了，如代理所在的机器Ip是192.168.1.88，端口9190
  # 下面配置改为
  # proxy: "http://192.168.1.88:9190"
  # In a local area network, only one proxy is required. For example, the IP of the machine where the proxy is located is 192.168.1.88 and the port is 9190
  # The following configuration is changed to
  # proxy: "http://192.168.1.88:9190"
  proxy: ""
scanPath: false     #是否扫盘
scanMinute: 60      #扫盘间隔（分钟）
```
