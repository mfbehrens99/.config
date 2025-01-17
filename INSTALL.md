# SETUP ARCH

> [!WARNING]
> Folge dem Guide im Arch Wiki, da dieser Guide nur grob zusammenfässt
>
> [https://wiki.archlinux.org/title/Installation_guide](https://wiki.archlinux.org/title/Installation_guide)

```sh
loadkeys de

# Falls WLAN:
ip link
```

List all partitions: `lsblk`

## Setup Filesystem

```sh
# Setup Diskencryption
cryptsetup luksFormat ...
cryptsetup luksOpen /dev/... main

# Create a btrfs filesystem
mkfs.btrfs /dev/mapper/main
mount /dev/mapper/main /mnt/btrfs
btrfs subvol create /mnt/btrfs/@arch
btrfs subvol create /mnt/btrfs/@home

# Mount drives
mount /dev/mapper/main -o subvol=@arch /mnt/arch
mount /dev/mapper/main -o subvol=@home /mnt/arch/home
mount /dev/... /mnt/boot

# Create basic system
pacstrap /mnt/arch base base-devel linux linux-firmware git 

genfstab -U /mnt/arch /mnt/arch/etc/fstab

# Chroot into new system
arch-chroot /mnt/root
```

## Install basics

```sh
pacman -S openssh sudo firefox ghostty sway gdm
```

Start Gnome display manager:

```sh
systemctl enable --now gdm
```

## Dotfiles

Clone your dotfiles to your `.config` folder.
Create symlinks from the dotfiles repository to your `.config` folder

```shell
ln -s ~/.config/dotfiles/{environment.d,gtk-3.0,gtk-4.0,libinput-gestures,mako,rofi,scripts,sway,swaylock,waybar,wlsunset,mimeapps.list,user-dirs.dirs,user-dirs.locale} ~/.config
```

## Snapper

> [!NOTE]
> You can also use btrfs-assistant to setup btrfs

Mount btrfs root

```
mount /dev/mapper/main /mnt/btrfs
```

Create a snapper config

```shell
snapper -c arch create-config /mnt/btrfs/@arch
snapper -c home create-config /mnt/btrfs/@home
```

Edit `/etc/snapper/configs/arch` to set how often the snapper should take a snapshot.

```shell
systemctl enable --now snapper-timeline.timer
systemctl enable --now snapper-cleanup.timer
```

Check if everything worked:

```shell
snapper list-configs
snapper list -a
```

## BTRFS Maintance

Install the btrfsmaintenance package with yay. All information can be read in the `README.md`.
Enable all the services the package provides:

```
systemctl enable --now btrfs-balance.timer
systemctl enable --now btrfs-defrag.timer
systemctl enable --now btrfs-scrub.timer
systemctl enable --now btrfs-trim.timer
```
