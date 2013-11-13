#!/bin/bash
set -e

DOWNLOAD_DIR=$(mktemp -d)
BUILD_DIR=$(mktemp -d)
RPM_RELEASE=1

trap "rm -rf $BUILD_DIR $DOWNLOAD_DIR && sudo yum remove -y python2.7" EXIT SIGINT SIGTERM

# Download and build Python 2.7.6
cd "$DOWNLOAD_DIR"
curl -O http://python.org/ftp/python/2.7.6/Python-2.7.6.tgz
tar zxvf Python-2.7.6.tgz
cd Python-2.7.6
./configure --enable-unicode=ucs4
make
make altinstall DESTDIR="$BUILD_DIR"

cd /vagrant
# Build python2.7 RPM
fpm -s dir -t rpm -n python2.7 -v 2.7.6 --iteration $RPM_RELEASE -C "$BUILD_DIR" \
    -p python2.7-FULLVERSION.ARCH.rpm \
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
fpm -s dir -t rpm -n python2.7-devel -v 2.7.6 --iteration $RPM_RELEASE -C "$BUILD_DIR" \
    -p python2.7-devel-FULLVERSION.ARCH.rpm \
    -d bash \
    -d python2.7 \
    usr/local/include

cd /vagrant
if [[ ! -f /usr/local/bin/python2.7 ]]; then
    sudo yum install -y python2.7-2.7.6*.rpm python2.7-devel-*.rpm
fi

function download_python_package  {
    cd "$BUILD_DIR"
    PACKAGE_ARR=(${1/-/ })

    curl -O https://pypi.python.org/packages/source/"${1:0:1}"/"${PACKAGE_ARR[0]}"/"$1".tar.gz
    tar zxf "$1".tar.gz
}

# Setuptools
PACKAGE=setuptools-1.3.1
download_python_package $PACKAGE
cd /vagrant
fpm -s python -t rpm \
    --python-bin python2.7 --python-package-name-prefix python2.7 \
    -d python2.7 \
    -d python2.7-devel \
    "$BUILD_DIR/$PACKAGE"/setup.py
sudo yum install -y python2.7-setuptools*.rpm

# Pip
PACKAGE=pip-1.4.1
download_python_package $PACKAGE
cd /vagrant
fpm -s python -t rpm \
    --python-bin python2.7 --python-package-name-prefix python2.7 \
    -d python2.7 \
    -d python2.7-devel \
    -d python2.7-setuptools \
    "$BUILD_DIR/$PACKAGE"/setup.py
sudo yum install -y python2.7-pip*.rpm

# Virtualenv
PACKAGE=virtualenv-1.10.1
download_python_package $PACKAGE
cd /vagrant
fpm -s python -t rpm \
    --python-bin python2.7 --python-package-name-prefix python2.7 \
    -d python2.7 \
    -d python2.7-devel \
    -d python2.7-setuptools \
    "$BUILD_DIR/$PACKAGE"/setup.py
sudo yum install -y python2.7-virtualenv*.rpm
