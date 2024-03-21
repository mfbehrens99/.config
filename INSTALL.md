# SETUP ARCH

```loadkeys de```

```ip link```

List all partitions: `lsblk`

## Setup Filesystem
```cryptsetup luksEncrypt```

luksopen

btrfs
btrfs subvols

mount btrfs @arch and @home

pacstrap

```bash
arch-chroot /mnt/root
```



## Install Sway
```
pacman -S git openssh opendoas firefox foot sway
```

?? not sure if this is needed
```systemctl enable --now seatd```


Add this code to your bash profile:
```shell
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
```

## Dotfiles

Create symlinks from the dotfiles repository to your `.config` folder
```shell
ln -s ~/dotfiles/{gtk-3.0,gtk-4.0,libinput-gestures,mako,rofi,scripts,sway,swaylock,waybar,wlsunset,mimeapps.list,user-dirs.dirs,user-dirs.locale} ~/.config
```

## Snapper
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