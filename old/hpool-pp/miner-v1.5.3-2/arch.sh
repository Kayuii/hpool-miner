#!/bin/sh
if [ "$TARGETARCH" = "amd64" ] ; then ARCH=amd64;fi
if [ "$TARGETARCH" = "arm64" ] ; then ARCH=aarch64;fi
if [ "$TARGETARCH" = "arm" ] ; then ARCH=arm;fi
VER=$1
# ARCH=linux
echo "https://github.com/hpool-dev/chiapp-miner/releases/download/1.5.3/HPool-Miner-chia-pp-v1.5.3-2-linux.zip"
wget -q --no-check-certificate https://github.com/hpool-dev/chiapp-miner/releases/download/1.5.3/HPool-Miner-chia-pp-v1.5.3-2-linux.zip -O /tmp/chia-miner.zip && unzip -j /tmp/chia-miner.zip "linux/hpool-miner-chia-linux-${ARCH}" -d /tmp/linux
