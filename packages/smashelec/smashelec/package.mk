# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

PKG_NAME="smashelec"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE=""
PKG_URL=""
PKG_MAINTAINER="cennis91"
PKG_DEPENDS_TARGET="toolchain emuelec"
PKG_SECTION="smashelec"
PKG_LONGDESC="SmashELEC meta package"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="manual"

# add packages here to include them in the build
PKG_DEPENDS_TARGET+=" emuelec-override mupen64plus-nx-se ucon64 xdelta3"


makeinstall_target() {
  mkdir -p $INSTALL/usr/config/smashelec
  mkdir -p $INSTALL/usr/config/smashelec/scripts

  cp -rf $PKG_DIR/config/* $INSTALL/usr/config/smashelec
  cp -rf $PKG_DIR/scripts/* $INSTALL/usr/config/smashelec/scripts

  mkdir -p $INSTALL/usr/config/smashelec/logs
  touch $INSTALL/usr/config/smashelec/logs/syslog
}