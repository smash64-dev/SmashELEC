# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

PKG_NAME="ucon64"
PKG_VERSION="2.2.0"
PKG_SHA256="5727e0be9ee878bba84d204135a7ca25662db6b56fee6895301e50c1bdda70af"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://ucon64.sourceforge.io/"
PKG_URL="https://downloads.sourceforge.net/$PKG_NAME/$PKG_NAME-$PKG_VERSION-src.tar.gz"
PKG_MAINTAINER="ucon64"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="smashelec"
PKG_LONGDESC="ROM backup tool and emulator's Swiss Army knife program"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="configure"


configure_package() {
  PKG_CONFIGURE_SCRIPT="$PKG_BUILD/src/configure"
}

pre_make_target() {
  cp -rf `ls -A` "$PKG_BUILD/src/"
  cd "$PKG_BUILD/src"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin/
  cp $PKG_NAME $INSTALL/usr/bin
}