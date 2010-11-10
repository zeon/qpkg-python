#!/bin/sh

QPKG_ROOTFS=/mnt/HDA_ROOT/rootfs_2_3_6

#remove symbolic links
/bin/rm -rf /usr/bin/2to3
/bin/rm -rf /usr/bin/idle
/bin/rm -rf /usr/bin/pydoc
/bin/rm -rf /usr/bin/python-config
/bin/rm -rf /usr/bin/python
/bin/rm -rf /usr/bin/python2.7
/bin/rm -rf /usr/bin/python2.7-config
/bin/rm -rf /usr/bin/smtpd.py
/bin/rm -rf /usr/lib/python2.7
/bin/rm -rf /usr/include/python2.7

/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/2to3
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/idle
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/pydoc
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python-config
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python2.7
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python2.7-config
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/smtpd.py
/bin/rm -rf ${QPKG_ROOTFS}/usr/bin/python
/bin/rm -rf ${QPKG_ROOTFS}/usr/lib/python2.7
/bin/rm -rf ${QPKG_ROOTFS}/usr/include/python2.7
