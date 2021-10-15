#!/usr/bin/env bash
#
# Script name: 0-base.sh
# Description: First part of my Arch Linux installation script
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# variables #
disk='/dev/sda'
disk_sufix=''

timedatectl set-ntp true

echo 'label: gpt
      size=500MiB, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="efi"
      type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="arch_root"
      ' | sfdisk --force $disk

mkfs.fat -F32 ${disk}${disk_sufix}1
mkfs.ext4 ${disk}${disk_sufix}2

mount ${disk}${disk_sufix}2 /mnt
mkdir -p /mnt/boot/efi
mount ${disk}${disk_sufix}1 /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware vim git

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt