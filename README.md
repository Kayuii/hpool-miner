# [kayuii/hpool-miner](https://github.com/Kayuii/hpool-miner)

An [hpool-chia-miner](https://github.com/hpool-dev/chia-miner) docker image.

## Tags

hpool-miner

update v1.2.0 Increase arm, aarch64 version

- `v1.2.0-5` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.2.0-5/Dockerfile))
- `v1.2.0` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.2.0/Dockerfile))
- `v1.1.1` ([Dockerfile](https://github.com/Kayuii/hpool-miner/blob/master/hpool/miner-v1.1.1/Dockerfile))

## Examples

`docker-compose` example for hpool-miner:

```yml
version: "3"

services:
  miner:
    image: kayuii/hpool-miner:v1.2.0-5
    restart: always
    volumes:
      - /mnt/dst:/mnt/dst
      - /opt/chia/logs:/opt/log
      - /opt/chia/config.yaml:/opt/config.yaml
    command:
      - hpool-miner

```

command-line example:

```sh
docker run -itd --rm  --name miner \
    -v "/mnt/dst:/mnt/dst" \
    -v "/opt/chia/logs:/opt/log" \
    -v "/opt/chia/config.yaml:/opt/config.yaml" \
    kayuii/hpool-miner:v1.2.0-5 hpool-miner
```
