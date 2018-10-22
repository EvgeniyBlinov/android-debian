#!/bin/bash
SCRIPT_PATH=`dirname $0`
ABSOLUTE_PATH=`readlink -m ${SCRIPT_PATH}`
ROOT_PATH=`readlink -m ${ABSOLUTE_PATH}/..`

TARGET="${ROOT_PATH}/system"

ACTION="$1"


function qemu_bin {
    sudo cp /usr/bin/qemu-arm-static "${TARGET}/usr/bin/"
}

function qemu_bin_rm {
    sudo rm "${TARGET}/usr/bin/qemu-arm-static"
}

function mount_dirs {
    #sudo mount --bind /dev "${TARGET}/dev/"
    sudo mount --bind /sys "${TARGET}/sys/"
    sudo mount --bind /proc "${TARGET}/proc/"
    #sudo mount --bind /dev/pts "${TARGET}/dev/pts"
}

function umount_dirs {
    sudo umount "${TARGET}/dev/pts"
    sudo umount "${TARGET}/sys/"
    sudo umount "${TARGET}/proc/"
    sudo umount "${TARGET}/dev/"
}


case "$ACTION" in
    up)
        qemu_bin
        mount_dirs
        sudo chroot "${TARGET}" /bin/bash
        umount_dirs
        qemu_bin_rm
        ;;
    *)
        qemu_bin_rm
        umount_dirs
        ;;
    #resume)
        #qemu_bin
        #mount_dirs
        #sudo chroot "${TARGET}" /bin/bash -c "/debootstrap/debootstrap --second-stage"
        #umount_dirs
        #qemu_bin_rm
        #;;
esac
