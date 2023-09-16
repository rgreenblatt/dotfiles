I had some issue where it goes "/boot" not mounted.
I think maybe due to misconfigured grub or similar?

Solution:

- arch usb
- mount ... /mnt
- mount ... /mnt/boot
- arch-chroot /mnt
- wifi
- pacman -Sy
- pacman -S linux
- pacman -S grub
- grub-install (following instructions, using /mnt/boot as esp)

