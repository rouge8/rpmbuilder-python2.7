#!/bin/bash
set -e

DOWNLOAD_DIR=$(mktemp -d)
BUILD_DIR=$(mktemp -d)
BUILD_TIME=$(date +%s)

trap "rm -rf $BUILD_DIR $DOWNLOAD_DIR" EXIT SIGINT SIGTERM

# Download and build Python 2.7.5
cd "$DOWNLOAD_DIR"
curl -O http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar jxvf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --enable-unicode=ucs4
make
make altinstall DESTDIR="$BUILD_DIR"

cd /vagrant
# Build python2.7 RPM
fpm -s dir -t rpm -n python2.7 -v 2.7.5-$BUILD_TIME -C "$BUILD_DIR" \
    -p python2.7-VERSION_ARCH.rpm \
    -d bash \
    -d bzip2-libs \
    -d coreutils \
    -d db4 \
    -d expat \
    -d gdbm \
    -d glibc \
    -d libffi \
    -d ncurses-libs \
    -d openssl \
    -d readline \
    -d sqlite \
    -d zlib \
    usr/local/bin usr/local/lib usr/local/share

# Build python2.7-devel RPM
fpm -s dir -t rpm -n python2.7-devel -v 2.7.5-$BUILD_TIME -C "$BUILD_DIR" \
    -p python2.7-devel-VERSION_ARCH.rpm \
    -d bash \
    -d python2.7 \
    usr/local/include
