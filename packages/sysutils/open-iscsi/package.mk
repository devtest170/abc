# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2012 Yann Cézard (eesprit@free.fr)
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="open-iscsi"
PKG_VERSION="2.1.9"
PKG_SHA256="60e2a1e3058a8af7f702e86a5a0511b05b8754d29d3d2df4e0e301399b5cf70a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/open-iscsi/open-iscsi"
PKG_URL="https://github.com/open-iscsi/open-iscsi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_INIT="toolchain util-linux"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain open-iscsi:host"
PKG_LONGDESC="The open-iscsi package allows you to mount iSCSI targets."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKE_OPTS_INIT="user"

PKG_MAKE_OPTS_TARGET="user"

pre_configure_init() {
  export OPTFLAGS="${CFLAGS} ${LDFLAGS}"
}

configure_init() {
  cd utils/open-isns
    ./configure --host=${TARGET_NAME} \
                --build=${HOST_NAME} \
                --with-security=no
  cd ../..
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/sbin
    cp -P ${PKG_BUILD}/usr/iscsistart ${INSTALL}/usr/sbin
}

pre_configure_host() {
  export OPTFLAGS="${CFLAGS} ${LDFLAGS}"
}

configure_host() {
  :
}

make_host() {
  cd ${PKG_BUILD}/utils
  make iscsi-iname
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp -P ${PKG_BUILD}/utils/iscsi-iname ${TOOLCHAIN}/bin
}

pre_configure_target() {
  export OPTFLAGS="${CFLAGS} ${LDFLAGS}"
}

configure_target() {
  cd utils/open-isns
    ./configure --host=${TARGET_NAME} \
                --build=${HOST_NAME} \
                --with-security=no

  cd ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin
    cp -P ${PKG_BUILD}/usr/iscsid ${INSTALL}/usr/sbin
    cp -P ${PKG_BUILD}/usr/iscsiadm ${INSTALL}/usr/sbin
    cp -P ${PKG_BUILD}/usr/iscsistart ${INSTALL}/usr/sbin
    cp -P ${PKG_BUILD}/utils/iscsi-iname ${INSTALL}/usr/sbin

  mkdir -p ${INSTALL}/etc/iscsi
    cp -P ${PKG_BUILD}/etc/iscsid.conf ${INSTALL}/etc/iscsi

    sed -i -e "s:= /sbin/iscsid:= /usr/sbin/iscsid:" ${INSTALL}/etc/iscsi/iscsid.conf

    echo "InitiatorName=$(${TOOLCHAIN}/bin/iscsi-iname)" >${INSTALL}/etc/iscsi/initiatorname.iscsi
}

post_install() {
  enable_service iscsi-initiator.service
}
