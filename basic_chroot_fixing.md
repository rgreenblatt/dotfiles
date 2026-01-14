# Fixing Borked Arch with Chroot

Boot from Arch install media, then:

## 1. Connect to WiFi

```bash
iwctl
station wlan0 connect "NetworkName"
# enter password when prompted
exit
```

## 2. Mount Filesystems

```bash
# Find your partitions
lsblk

# Mount root partition
mount /dev/sdXn /mnt
```

## 3. Chroot

```bash
arch-chroot /mnt
```

Now you're in your broken system. Fix whatever's wrong (reinstall packages, edit configs, etc.).

When done: `exit`, `umount -R /mnt`, `reboot`.
