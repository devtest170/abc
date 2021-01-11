# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
PKG_NAME="crossguid"
PKG_VERSION="8f399e8bd4252be9952f3dfa8199924cc8487ca4"
PKG_VERSION="ca1bf4b810e2d188d04cb6286f957008ee1b7681"
#PKG_SHA256="6be27e0b3a4907f0cd3cfadec255ee1b925569e1bd06e67a4d2f4267299b69c4"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/graeme-hill/crossguid"
PKG_URL="https://github.com/graeme-hill/crossguid/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_LONGDESC="minimal, cross platform, C++ GUID library"
PKG_TOOLCHAIN="manual"

make_target() {
  ls -la
  pwd
  ${CXX} -I ../include -c ../src/guid.cpp -o guid.o ${CXXFLAGS} -std=c++11 -DGUID_LIBUUID
  ${AR} rvs libcrossguid.a guid.o
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/
  cp libcrossguid.a ${SYSROOT_PREFIX}/usr/lib/
  mkdir -p ${SYSROOT_PREFIX}/usr/include/
  cp ../include/crossguid/guid.hpp ${SYSROOT_PREFIX}/usr/include
}
