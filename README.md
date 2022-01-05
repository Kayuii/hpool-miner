# [kayuii/hpool-miner](https://github.com/Kayuii/hpool-miner)

[![Build Status](https://travis-ci.com/Kayuii/hpool-miner.svg?branch=master)](https://travis-ci.com/Kayuii/hpool-miner)

An [hpool-chia-miner](https://github.com/hpool-dev/chia-miner) docker image.

## docker hub:
[hpool-chia-og-miner](https://hub.docker.com/r/kayuii/hpool-miner)

[hpool-chia-pp-miner](https://hub.docker.com/r/kayuii/hpool-pp-miner)

## Tags

hpool-og-miner

update v1.2.0 Increase arm, aarch64 version

2021-06-11 add docker-entrypoint.sh, gosu, tini

- `v1.5.6-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.5.6-1/Dockerfile))
- `v1.5.3-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.5.3-1/Dockerfile))
- `v1.5.2-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.5.2-1/Dockerfile))
- `v1.5.1-3` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.5.1-3/Dockerfile))
- `v1.5.0-7` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.5.0-7/Dockerfile))
- `v1.4.2-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.4.2-1/Dockerfile))
- `v1.4.1-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.4.1-1/Dockerfile))
- `v1.4.0-2` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-og/miner-v1.4.0-2/Dockerfile))

x-proxy-og

- `v1.0.9` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/x-proxy-og/xproxy-v1.0.9/Dockerfile))
- `v1.6.0` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/x-proxy-og/xproxy-v1.6.0/Dockerfile))
- `v1.0.5` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/x-proxy-og/xproxy-v1.0.5/Dockerfile))
- `v1.0.4` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/x-proxy-og/xproxy-v1.0.4/Dockerfile))


hpool-pp-miner

- `v1.5.3-2` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-pp/miner-v1.5.0-2/Dockerfile))
- `v1.5.0-2` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-pp/miner-v1.5.0-2/Dockerfile))
- `v1.5.0-1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool-pp/miner-v1.5.0-1/Dockerfile))

x-proxy-pp

- `v1.0.7` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/x-proxy-pp/xproxy-v1.0.7/Dockerfile))
- `v1.0.4` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/x-proxy-pp/xproxy-v1.0.4/Dockerfile))

## Examples

### for hpool-og-miner

`docker-compose` example :

```yml
version: "3"

services:
  miner:
    image: kayuii/hpool-miner:v1.5.0-7
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
    image: kayuii/hpool-miner:v1.5.0-7
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
      - LANG=cn
      - PROXY=http://192.168.1.88:9190
      - MTLOAD=true
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
    -e 'DIR=["/mnt/dst"]' \
    -e "APIKEY=1df8e525-772f-40e9-908d-0f26e36f8046" \
    -e 'HOSTNAME=miner' \
    -e 'LOGPATH=./logs/' \
    -e 'SCAN=30' \
    -e 'LANG=cn' \
    -e 'PROXY=http://192.168.1.88:9190' \
    -e 'MTLOAD=true' \
    kayuii/hpool-miner:v1.5.0-7 hpool-chia-miner
```

default config.yaml

```yaml
token: ""
path: []                   #扫盘路径
minerName:                 #矿机名称（自定义）
apiKey:                    #hpool apikey
cachePath: ""
deviceId: ""
extraParams: {}
log:
  lv: info
  path: ./log/
  name: miner.log
url:
  info: ""
  submit: ""
  line: ""
  ws: ""
  proxy: ""                # 一个局域网内，代理只需要开一台就可以了，如代理所在的机器Ip是192.168.1.88，端口9190
scanPath: false            #是否扫盘
scanMinute: 60             #扫盘间隔（分钟）
debug: ""
language: cn
line: cn                   # 中国大陆以外地区如果连不上服务器，建议选择日本线路。 jp
multithreadingLoad: false  # 文件扫盘方式  false 单盘逐个加载 true 多盘同时加载
```

### for hpool-pp-miner

`docker-compose` example :

```yml
version: "3"

services:
  miner:
    image: kayuii/hpool-pp-miner:v1.5.0-2
    restart: always
    volumes:
      - /mnt/dst:/mnt/dst
      - /opt/chia/logs:/opt/log
      - /opt/chia/config.yaml:/opt/config.yaml
    command:
      - hpool-chiapp-miner
```
or
```yml
version: "3"

services:
  miner:
    image: kayuii/hpool-pp-miner:v1.5.0-2
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
    command:
      - hpool-chiapp-miner
```

command-line example:

```sh
docker run -itd --rm  --name miner \
    -v "/mnt/dst:/mnt/dst" \
    -v "/opt/chia/logs:/opt/log" \
    -v "/opt/chia/config.yaml:/opt/config.yaml" \
    kayuii/hpool-pp-miner:v1.5.0-2 hpool-chiapp-miner
```
or
```sh
docker run -itd --rm  --name miner \
    -v "/mnt/dst:/mnt/dst" \
    -v "/opt/chia/logs:/opt/log" \
    -e 'DIR=["/mnt/dst"]' \
    -e "APIKEY=1df8e525-772f-40e9-908d-0f26e36f8046" \
    -e 'HOSTNAME=miner' \
    -e 'LOGPATH=./logs/' \
    -e 'SCAN=30' \
    kayuii/hpool-pp-miner:v1.5.0-2 hpool-chiapp-miner
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
  proxy: ""
scanPath: false     #是否扫盘
scanMinute: 60      #扫盘间隔（分钟）
```
