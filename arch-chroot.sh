#!/bin/bash

mkdir /mnt
mount -o subvol=@ /dev/nvme0n1p5 /mnt
rm -rf /mnt/*

mkdir /mnt/home
mount -o subvol=@home /dev/nvme0n1p5 /mnt/home
rm -rf /mnt/home/*

mkdir /mnt/mnt
mkdir /mnt/mnt/defvol
mount -o subvol=/ /dev/nvme0n1p5 /mnt/mnt/defvol

mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p2 /mnt/boot/efi

mkdir /mnt/games
mount /dev/sda2 /mnt/games

mkdir /mnt/storagedrive
mount /dev/sdb2 /mnt/storagedrive

mkdir /mnt/software
mount /dev/nvme1n1p2 /mnt/software

swapon /dev/nvme0n1p6

pacstrap -K /mnt amd-ucode base base-devel bash-completion btrfs-progs git linux linux-firmware nano ntfs-3g sudo openssh

cp -R . /mnt/root

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
