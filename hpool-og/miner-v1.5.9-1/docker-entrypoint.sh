#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for hpool-chia-miner"
    set -- hpool-chia-miner "$@"
fi

if [ ! -f config.yaml ]; then
cat <<-EOF > "/opt/config.yaml"
token: ""
path: []
minerName:
apiKey:
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
  proxy: ""
scanPath: false
scanMinute: 60
debug: ""
language: cn
line: cn
multithreadingLoad: false
# socket5 or http proxy
proxy:
  # E.g http://127.0.0.1:8888 socket5://127.0.0.1:8888
  url: ""
  username: ""
  password: ""
EOF
fi

if [ "$1" = "hpool-chia-miner" ] ; then
    if [ -n "$DIR" ]; then
        echo "$(sed "/path: \[\]$/c path: $DIR" config.yaml)" > config.yaml
    fi
    if [ -n "$APIKEY" ]; then
        echo "$(sed "/apiKey:$/c apiKey: $APIKEY" config.yaml)" > config.yaml
    fi
    if [ -n "$HOSTNAME" ]; then
        echo "$(sed "/minerName:$/c minerName: $HOSTNAME" config.yaml)" > config.yaml
    fi
    if [ -n "$PROXY" ]; then
        echo "$(sed "s!proxy: \"\"!proxy: \"$PROXY\"!g" config.yaml)" > config.yaml
    fi
    if [ -n "$LANG" ]; then
        echo "$(sed "/line: cn/cline: $LANG" config.yaml)" > config.yaml
    fi
    if [ -n "$LOGPATH" ]; then
        echo "$(sed "s:./log/:$LOGPATH:g" config.yaml)" > config.yaml
        mkdir -p "$LOGPATH"
        chown -R chia "$LOGPATH"
        chown -h chia:chia "$LOGPATH"
    else
        mkdir -p ./log/
        chown -R chia ./log/
        chown -h chia:chia ./log/
    fi
    if [ -n "$SCAN" ]; then
        echo "$(sed "/scanPath/c scanPath: true" config.yaml)" > config.yaml
        echo "$(sed "/scanMinute/c scanMinute: $SCAN" config.yaml)" > config.yaml
    fi
    if [ -n "$MTLOAD" ]; then
        echo "$(sed "/multithreadingLoad: false/c multithreadingLoad: true" config.yaml)" > config.yaml
    fi
    chown -R chia .
    chown -h chia:chia .
    cat config.yaml
    echo "run : $@ "
    exec gosu chia "$@"
fi

echo "run some: $@"
exec "$@"
