#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for x-proxy"
    set -- x-proxy "$@"
fi

if [ "$1" = "x-proxy" ] ; then

    if [ -n "$LOGPATH" ]; then
        sed -i "s:./log/:$LOGPATH:g" config.yaml
    else
        LOGPATH=./log/
        sed -i "s:./log/:$LOGPATH:g" config.yaml
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
