################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2020-present AmberELEC (https://github.com/AmberELEC)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="mame2010"
PKG_VERSION="5f524dd5fca63ec1dcf5cca63885286109937587"
PKG_SHA256="deb2a5126fcf9791ebaaba604143b6fb1bf4fa48fdc7a2ef919c900a3f9e4d69"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2010-libretro"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Late 2010 version of MAME (0.139) for libretro. Compatible with MAME 0.139 romsets."
PKG_LONGDESC="Late 2010 version of MAME (0.139) for libretro. Compatible with MAME 0.139 romsets."

PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

make_target() {
  if [ "$ARCH" == "arm" ]; then
    make CC="$CC" LD="$CC" PLATCFLAGS="$CFLAGS" PTR64=0 ARM_ENABLED=1 LCPU=arm
  elif [ "$ARCH" == "i386" ]; then
    make CC="$CC" LD="$CC" PLATCFLAGS="$CFLAGS" PTR64=0 ARM_ENABLED=0 LCPU=x86
  elif [ "$ARCH" == "x86_64" ]; then
    make CC="$CC" LD="$CC" PLATCFLAGS="$CFLAGS" PTR64=1 ARM_ENABLED=0 LCPU=x86_64
  elif [ "$ARCH" == "aarch64" ]; then
    make CC="$CC" LD="$CC" PLATCFLAGS="$CFLAGS" PTR64=1 ARM_ENABLED=1 LCPU=arm64
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mame2010_libretro.so $INSTALL/usr/lib/libretro/
}
