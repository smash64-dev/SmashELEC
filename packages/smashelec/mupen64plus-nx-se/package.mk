# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

PKG_NAME="mupen64plus-nx-se"
PKG_VERSION="e90501a315fd91e7d9eab221127901e25839440f"
PKG_SHA256="a16924150fb4ec32ae23ed5868e113cfeef572da481185378a2181acd96b7df3"
PKG_ARCH="arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/smash64-dev/mupen64plus-libretro-nx-se/"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_MAINTAINER="cennis91"
PKG_DEPENDS_TARGET="toolchain nasm:host $OPENGLES"
PKG_SECTION="libretro"
PKG_LONGDESC="mupen64plus_next + RSP-HLE + GLideN64 + libretro + raphnetraw"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"


pre_configure_target() {
  sed -e "s|^GIT_VERSION ?.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile
}

if [ ${PROJECT} = "Amlogic-ng" ]; then
	PKG_MAKE_OPTS_TARGET+=" platform=AMLGX"
fi

PKG_MAKE_OPTS_TARGET+=" CORE_NAME=\"mupen64plus-smash\""

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mupen64plus_next_smash_libretro.so $INSTALL/usr/lib/libretro/
  cp $PKG_DIR/config/mupen64plus_next_smash_libretro.info $INSTALL/usr/lib/libretro/
}
