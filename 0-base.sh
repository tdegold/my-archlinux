#!/usr/bin/env bash
#
# Script name: 0-base.sh
# Description: First part of my Arch Linux installation script
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# Env. variables #
DISK='/dev/sda'
DISK_SUFIX=''

timedatectl set-ntp true

echo "label: gpt
      size=500MiB, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="efi"
      type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="arch_root"
      " | sfdisk --force $DISK

mkfs.fat -F32 ${DISK}${DISK_SUFIX}1
mkfs.ext4 ${DISK}${DISK_SUFIX}2