#!/bin/bash
SCRIPT_PATH=`dirname $0`
ABSOLUTE_PATH=`readlink -m ${SCRIPT_PATH}`
ROOT_PATH=`readlink -m ${ABSOLUTE_PATH}/..`

ARCH='armhf'
RELEASE='stretch'
MIRROR='http://ftp.ru.debian.org/debian/'
#RELEASE='xenial'
#MIRROR='http://ports.ubuntu.com'
TARGET="${ROOT_PATH}/system"

sudo qemu-debootstrap \
    --foreign \
    --arch="${ARCH}" \
    "${RELEASE}" \
    "${TARGET}" \
    "${MIRROR}"

## Add debian root user to inet group
#groupadd -g 3003 inet
#usermod -a -G inet root

## Change dns server
#rm /etc/resolv.conf
#echo "nameserver 8.8.8.8" > /etc/resolv.conf
