# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pixman"
PKG_VERSION="0.40.0"
PKG_SHA256="6d200dec3740d9ec4ec8d1180e25779c00bc749f94278c8b9021f5534db223fc"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="Pixman is a generic library for manipulating pixel regions, contains low-level pixel manipulation routines."

if [ "$TARGET_ARCH" = arm ]; then
  if target_has_feature neon; then
    PIXMAN_NEON="--enable-arm-neon"
  else
    PIXMAN_NEON="--disable-arm-neon"
  fi
  PIXMAN_CONFIG="--disable-mmx --disable-sse2 --disable-vmx --enable-arm-simd $PIXMAN_NEON --disable-arm-iwmmxt"
elif [ "$TARGET_ARCH" = aarch64 ]; then
  PIXMAN_CONFIG="--disable-mmx --disable-sse2 --disable-vmx --disable-arm-simd --disable-arm-neon --disable-arm-iwmmxt"
elif [ "$TARGET_ARCH" = x86_64  ]; then
  PIXMAN_CONFIG="--enable-mmx --enable-sse2 --disable-ssse3 --disable-vmx --disable-arm-simd --disable-arm-neon"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-openmp \
                           --disable-loongson-mmi \
                           $PIXMAN_CONFIG \
                           --disable-mips-dspr2 \
                           --enable-gcc-inline-asm \
                           --disable-timers \
                           --disable-gtk \
                           --disable-libpng \
                           --with-gnu-ld"

post_makeinstall_target() {
  cp $SYSROOT_PREFIX/usr/lib/pkgconfig/pixman-1.pc \
     $SYSROOT_PREFIX/usr/lib/pkgconfig/pixman.pc
  cp -rf $SYSROOT_PREFIX/usr/include/pixman-1 \
     $SYSROOT_PREFIX/usr/include/pixman
}
