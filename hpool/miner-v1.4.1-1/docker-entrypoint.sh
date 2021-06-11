#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for hpool-chia-miner"
    set -- hpool-chia-miner "$@"
fi

if [ "$1" = "hpool-chia-miner" ] ; then
    if [ -n "$DIR" ]; then
        sed -i "/path:$/c path: $DIR" config.yaml
    else
        sed -i "/path:$/c path: [ '/mnt/dst' ]" config.yaml
    fi
    if [ -n "$APIKEY" ]; then
        sed -i "/apiKey/c apiKey: $APIKEY" config.yaml
    fi
    if [ -n "$HOSTNAME" ]; then
        sed -i "/minerName/c minerName: $HOSTNAME" config.yaml
    fi
    if [ -n "$PROXY" ]; then
        sed -i "s!proxy: \"\"!proxy: \"$PROXY\"!g" config.yaml
    fi
    if [ -n "$LOGPATH" ]; then
        sed -i "s:./log/:$LOGPATH:g" config.yaml
    else
        LOGPATH=./log/
        sed -i "s:./log/:$LOGPATH:g" config.yaml
    fi
    if [ -n "$SCAN" ]; then
        sed -i "/scanPath/c scanPath: true" config.yaml
        sed -i "/scanMinute/c scanMinute: $SCAN" config.yaml
    fi
    cat config.yaml
    mkdir -p "$LOGPATH"
    chown -R chia "$LOGPATH"
    chown -h chia:chia "$LOGPATH"
    echo "run : $@ "
    exec gosu chia "$@"
fi

echo "run some: $@"
exec "$@"
