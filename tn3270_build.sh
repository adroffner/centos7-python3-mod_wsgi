#! /bin/bash
#
# Build IBM-3270 "telnet 3270" for Python 3.x.x from source on CentOS Linux.
# =============================================================================
# See: x3270 Project and provide the "headless" s3270 command only.
# =============================================================================

echo "IBM-3270 headless terminal support ... adding"

X3270_VERSION="3.6ga5"
X3270_SHORT_VERSION="3.6"
X3270_SRC_URL="http://prdownloads.sourceforge.net/x3270/suite3270-${X3270_VERSION}-src.tgz"

# Install libraries before building.
# None

# Download and build x3270 program(s) for $X3270_VERSION
# =============================================================================
cd /usr/src

wget -O x3270.tar.gz "${X3270_SRC_URL}"
tar -xzf x3270.tar.gz
cd ./suite3270-${X3270_SHORT_VERSION}

./configure --prefix=/usr/ --enable-s3270
make
make install

cd -
rm /usr/src/x3270.tar.gz
rm -R /usr/src/suite3270-${X3270_SHORT_VERSION}
