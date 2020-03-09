#!/bin/bash

loadkeys la-latin1

echo "-----------Pinging-----------"
ping -c 3 google.com

timedatectl set-ntp true

lsblk

echo "-----------Formatting-----------"
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

echo "-----------Make swap-----------"
mkswap /dev/sda2
swapon /dev/sda2

echo "-----------Mounting-----------"
mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sda4/ /mnt/home

lsblk

echo "-----------Installing Linux -----------"
pacstrap -i /mnt base base-devel linux linux-firmware vim netctl dhcpcd wpa_supplicant dialog git

genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt/bin/bash




