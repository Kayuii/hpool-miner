#!/bin/sh
if [ "$TARGETARCH" = "amd64" ] ; then ARCH=linux;fi
if [ "$TARGETARCH" = "arm64" ] ; then ARCH=aarch64;fi
if [ "$TARGETARCH" = "arm" ] ; then ARCH=arm;fi
VER=$1
echo "https://github.com/hpool-dev/chia-miner/releases/download/${VER}/x-proxy-og-v1.0.5.zip"
wget -q --no-check-certificate https://github.com/hpool-dev/chia-miner/releases/download/${VER}/x-proxy-og-v1.0.5.zip -O /tmp/chia-miner.zip && unzip -j /tmp/chia-miner.zip -d /tmp/linux
