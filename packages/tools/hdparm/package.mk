# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hdparm"
PKG_VERSION="9.61"
PKG_SHA256="da1a1c3887f10b8397e8e02013caa61142e0e72cb0d73997421ca2f2f4df5343"
PKG_LICENSE="BSD"
PKG_SITE="http://sourceforge.net/projects/hdparm/"
PKG_URL="${SOURCEFORGE_SRC}/${PKG_NAME}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Shell utility to access/tune ioctl features of the Linux IDE driver and IDE drives."

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin
    cp -a ${PKG_BUILD}/hdparm ${INSTALL}/usr/sbin
}
