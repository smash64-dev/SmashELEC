# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

PKG_NAME="mupen64plus-nx-se"
PKG_VERSION="f5e7017038cd8987167d69f47ac785c49b44c682"
PKG_SHA256="7fe4c3f1466e568e362b111883eac6bcf3dc4bd60d4241e854ea65934b67f3b2"
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
	PKG_MAKE_OPTS_TARGET+=" platform=AMLG12 GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm"
elif [ "${PROJECT}" = "Amlogic" ]; then
	PKG_MAKE_OPTS_TARGET+=" platform=AMLGX GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm"
elif [ "${DEVICE}" = "OdroidGoAdvance" ]; then
	PKG_MAKE_OPTS_TARGET+=" platform=odroidgoa"
fi

PKG_MAKE_OPTS_TARGET+=" CORE_NAME=\"mupen64plus-smash\""

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mupen64plus_next_smash_libretro.so $INSTALL/usr/lib/libretro/
}
