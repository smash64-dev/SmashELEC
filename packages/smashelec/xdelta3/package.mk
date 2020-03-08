# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

PKG_NAME="xdelta3"
PKG_VERSION="v3.1.0"
PKG_SHA256="7515cf5378fca287a57f4e2fee1094aabc79569cfe60d91e06021a8fd7bae29d"
PKG_ARCH="any"
PKG_LICENSE="Apache"
PKG_SITE="https://github.com/jmacd/xdelta"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_MAINTAINER="Josh Macdonald"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="smashelec"
PKG_LONGDESC="open-source binary diff, delta/differential compression tools, VCDIFF/RFC 3284 delta compression"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="configure"


pre_configure_target() {
  cd $PKG_NAME
  autoreconf --install
}

configure_package() {
  PKG_CONFIGURE_SCRIPT="$PKG_BUILD/$PKG_NAME/configure"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin/
  cp $PKG_NAME $INSTALL/usr/bin
}