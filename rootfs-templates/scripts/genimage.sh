#!/bin/bash

set -e

ROOTFS_PATH=$(find ${PWD} -maxdepth 1 -mindepth 1 -type d -name '.debos-*' -printf '%T@ %p\n' | sort -nr | head -n 1 | awk '{ print $2 }')/root
ROOTFS_SIZE=$(du -sm $ROOTFS_PATH | awk '{ print $1 }')

ZIP_NAME=${1}
WORK_DIR=${ZIP_NAME}.work
OUT_PATH="out/${ZIP_NAME}.tar.gz"

clean() {
	rm -rf ${WORK_DIR}
}
trap clean EXIT

# Create temporary work dir
mkdir -p ${WORK_DIR}
mkdir -p out

# Create archive from rootfs
tar -czvf "${OUT_PATH}" -C "${ROOTFS_PATH}" .

# Copy output to current directory with fixed name for workflow (optional)
cp "${OUT_PATH}" "./lindroid-kde-rootfs.tar.gz"

echo "Generated archive:"
ls -lh "${OUT_PATH}"
