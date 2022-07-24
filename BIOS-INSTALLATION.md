# BIOS Installation Instructions
This is based on the INSTALLATION.md file. It shows how to isntall
arch on a BIOS machine.

Installation also based from [Erik Dubois'](https://www.youtube.com/c/ErikDubois) youtube tutorials.
In particular, Arch Linux series 
[45](https://www.youtube.com/watch?v=3iesq_ep5Wo&ab_channel=ErikDubois)
[46](https://www.youtube.com/watch?v=buDO6OwT0Rk&ab_channel=ErikDubois)
[47](https://www.youtube.com/watch?v=54GBZbhvEto&ab_channel=ErikDubois)
[48](https://www.youtube.com/watch?v=8ppVC95Y64Q&ab_channel=ErikDubois)
[49](https://www.youtube.com/watch?v=y_InwyDUiRQ&ab_channel=ErikDubois).


Installation is done from the live bootable device environment.


## 1. Create File System
First check the current devices detected by the system.
```
# fdisk -l
```

Create a new file system scheme with the `cfdisk` program, and create
the partition schema.


### 1.3 Format partitions
Each newly created partition must be formatted with the appropriate file system.
```
# mkfs.ext4 /dev/sda1
# mkswap /dev/sda2
```

### 1.4 Mount the file systems
Just mount the root and swap.
```
# mount /dev/sda1 /mnt
# swapon /dev/sda2
```


## 2. Installation
Use the `pacstrap` script to install the base package, Linux kernel and firmware for common hardware.
```
# pacstrap /mnt base linux linux-firmware
```

You can substitute linux for a kernel package of your choice, or you could omit it entirely when installing in a container.
You could omit the installation of the firmware package when installing in a virtual machine or container.

## 3. System Configuration
Generate an `fstab` file.
```
# genfstab -U /mnt >> /mnt/etc/fstab
```

Change root into the new system.
```
# arch-chroot /mnt
```
This will take root user inside the new machine. Perform all following 
configurations from this root.

### Install basic utilities
Install basics
```
# pacman -S vim man-db man-pages texinfo
```

#### Set localtime.
```
# ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
# hwclock --systohc
```

#### Set the root password.
```
# passwd
```

## 4. Bootloader Installation
We will use GRUB as the bootloader. First install the grub utils.
```
# pacman -S grub
```

And install grub init loader, and save the configuration file.
```
# grub-install /dev/sda
# grub-mkconfig -o /boot/grub/grub.cfg
```
