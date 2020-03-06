#!/bin/bash

echo "[Localtime]"
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime 2>/dev/null && echo "Ok" || echo "Fail"

echo "[hwclock]"
hwclock --systohc 2>/dev/null && echo "Ok" || echo "Fail"

echo "[locale]"
cp locale.gen /etc/locale.gen 2>/dev/null && echo "Ok" || echo "Fail copy"
locale-gen 2>/dev/null && echo "Ok" || echo "Fail localegen"

echo "[LANG & KEYMAP"]
echo LANG=es_MX.UTF-8 > /etc/locale.conf 2>/dev/null && echo "Ok" || echo "Fail"
echo KEYMAP=es_latin1 > /etc/vconsole.conf 2>/dev/null && echo "Ok" || echo "Fail"
echo arroyo > /etc/hostname 2>/dev/null && echo "Ok" || echo "Fail"
echo "127.0.1.1    localhost.localdomain arroyo" >> /etc/hosts 2>/dev/null && echo "Ok" || echo "Fail"

echo "[Install Packages]"
pacman -S networkmanager grub efibootmgr && echo "Ok" || echo "Fail"

echo "[Network Manager]"
systemctl enable NetworkManager 2>/dev/null && echo "Ok" || echo "Fail"

echo "[Password]"
passwd && echo "Ok" || echo "Fail copy"

echo "[EFI]"
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/GRUB/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI
echo "bcf boot add 1 fs0:\EFI\GRUB\grubx64.efi 'My GRUB bootloader'" > /boot/efi/startup.nsh
umount -R /mnt

echo "Instalación finalizada, por favor reinicia el sistema"



