# Arch Install

This just contains a few notes, mostly just follow installation_guide

https://wiki.archlinux.org/index.php/installation_guide

## Connect to internet

Consider running `rfkill unblock wifi`

https://wiki.archlinux.org/index.php/Iwd#iwctl

(remember that scan doesn't output anything)

## Mirror setup

Step 6 of https://itsfoss.com/install-arch-linux/

## Install essential

```
pacstrap /mnt base linux linux-firmware neovim iwd networkmanager man-db \
  man-pages texinfo ntp openssh zsh base-devel wget intel-ucode grub \
  efibootmgr sudo
```
Replace `intel-ucode` as needed. Some installs could be done later.

## Boot loader

After chroot

https://wiki.archlinux.org/index.php/GRUB#Installation_2

```
mkdir -p /efi
mount <EFI_PARTITION> /efi
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

If grub isn't detected, check /etc/fstab and also maybe instead
run
```
grub-install --target=x86_64-efi --efi-directory=/efi --removable
```
and then rerun `grub-mkconfig`
Might also help to reinstall `linux linux-firmware`?

(from default/fallback boot path in install instructions)


## Systemd enable

```
systemctl enable NetworkManager
systemctl enable iwd
systemctl enable ntpd
systemctl enable sshd
```

## After reboot setup

Connect to wifi with nmcli

If no internet but device connects, maybe:
```
sudo pacman -S dhcpcd
sudo systemctl enable dhcpcd.service
sudo systemctl start dhcpcd.service
```

### User

Uncomment  `%wheel ALL=(ALL:ALL) ALL` in `/etc/sudoers`.

```
useradd -m -g users -G wheel -s /bin/zsh ryan
passwd ryan
```

### yay

```
su ryan
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R ryan:users ./yay-git
cd yay-git
makepkg -si
```

Might also need to run (for systemd-resolve):
```
rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

To fix gpg issues, might need (permissions might be wrong!):
```
mkdir /home/$USER/.gnupg/
echo "keyserver hkp://pool.sks-keyservers.net" > /home/$USER/.gnupg/gpg.conf
```
