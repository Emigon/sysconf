#!/bin/bash
# a script used to rebuild the kernel

rm -rf /boot/* # start from scratch
KDIR=/usr/src/linux

make -C $KDIR
make -C $KDIR modules_install
make -C $KDIR install

genkernel --install initramfs # initramfs setup

grub-install
grub-install --target=x86_64-efi --efi-directory=/boot --removable
grub-mkfont -v -o /boot/grub/ter-x32n.pf2 ter-x32n.pcf.gz
grub-mkconfig -o /boot/grub/grub.cfg
