#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for x-proxy"
    set -- x-proxy "$@"
fi
if [ ! -f config.yaml ]; then
cat <<-EOF > "/opt/config.yaml"
server:
  host: 0.0.0.0
  port: 9190
  url: ""
log:
  level: "info"
  out: "./log/proxy.log"
dbFile: "proxy.db"
dbFile: "/opt/db/proxy.db"
chains:
  -
    chain: mass
    apiKey: "mass"
  -
    chain: chia
    apiKey: "chia"
EOF
fi

if [ "$1" = "x-proxy" ] ; then
    mkdir -p /opt/log/ /opt/db/

    if [ -n "$LOGPATH" ]; then
        sed -i "s:./log/:$LOGPATH:g" config.yaml
    else
        LOGPATH=/opt/log/
        sed -i "s:./log/:$LOGPATH:g" config.yaml
    fi
    if [ -n "$DBDIR" ]; then
        sed -i "s:./log/:$DBDIR:g" config.yaml
    else
        DBDIR=/opt/db/proxy.db
        sed -i "s:proxy.db:$DBDIR:g" config.yaml
    fi

    sed -i "s:apiKey: \"mass\":apiKey: \"$MASSAPI\":g" config.yaml
    sed -i "s:apiKey: \"chia\":apiKey: \"$CHIAAPI\":g" config.yaml

    cat config.yaml
    chown -R chia ./
    chown -h chia:chia ./
    mkdir -p "$LOGPATH"
    chown -R chia "$LOGPATH"
    chown -h chia:chia "$LOGPATH"
    echo "run : $@ "
    exec gosu chia "$@"
fi

echo "run some: $@"
exec "$@"
