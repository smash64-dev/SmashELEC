# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

PKG_NAME="emuelec-override"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE=""
PKG_URL=""
PKG_MAINTAINER="cennis91"
PKG_DEPENDS_TARGET="toolchain emuelec"
PKG_SECTION="smashelec"
PKG_LONGDESC="SmashELEC EmuELEC overlay"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # override emuelec flat files from sx05re/ packages
  mkdir -p $INSTALL/usr/config
  cp -rf $PKG_DIR/config/* $INSTALL/usr/config/
}
