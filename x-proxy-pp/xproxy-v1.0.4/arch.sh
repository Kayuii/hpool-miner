#!/bin/sh
if [ "$TARGETARCH" = "amd64" ] ; then ARCH=linux;fi
if [ "$TARGETARCH" = "arm64" ] ; then ARCH=aarch64;fi
if [ "$TARGETARCH" = "arm" ] ; then ARCH=arm;fi
VER=$1
echo "https://github.com/hpool-dev/chiapp-miner/releases/download/${VER}/x-proxy-pp-v1.0.4.zip"
wget -q --no-check-certificate https://github.com/hpool-dev/chiapp-miner/releases/download/${VER}/x-proxy-pp-v1.0.4.zip -O /tmp/chia-miner.zip && unzip -j /tmp/chia-miner.zip -d /tmp/linux
