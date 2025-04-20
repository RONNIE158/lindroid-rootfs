#!/bin/bash
set -e

ROOTFS_PATH=$(find "${PWD}" -maxdepth 1 -mindepth 1 -type d -name '.debos-*' -printf '%T@ %p\n' | sort -nr | head -n 1 | awk '{ print $2 }')/root

mkdir -p out

echo "Packing rootfs to tar.gz..."
tar -czf out/lindroid-kde-rootfs.tar.gz -C "${ROOTFS_PATH}" .

echo "Done. Output:"
ls -lh out/lindroid-kde-rootfs.tar.gz
