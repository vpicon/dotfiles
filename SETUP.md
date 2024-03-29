# System Setup
This document gives initial setup steps as done in my machine.
The following installation assumes a UEFI firmware board.

This installation follows the [official arch install guide](https://wiki.archlinux.org/title/Installation_guide).

Installation is done from a live bootable device environment (USB).


## 1. Create File System
First check the current devices detected by the system.
```
# fdisk -l
```

Create a new file system scheme with the `gnu-parted` program, already in bootable virutal console environment.
Enter the command:
```
# parted /dev/sdx
```
To enter `parted` in interactive mode, where `sdx` is the device where to install the file system.


### 1.1 Create a new partition scheme
In the `parted` console create a new partition scheme. 
```
(parted) mklabel gpt
```

### 1.2 Create partitions
The scheme will be composed of partition:
- __boot__: 300 MiB.
- __root__ (the `/` directory): ~25 GiB.
- __swap__: 5 GiB.
- __home__ (the `/home` directory): All remaining space.

Enter the following commands in the `gparted` interactive shell.
```
(parted) mkpart "efi system partition" fat32 1MiB 301MiB
(parted) set 1 esp on
(parted) mkpart "root partition" ext4 301MiB 25GiB
(parted) mkpart "swap partition" linux-swap 25GiB 30GiB
(parted) mkpart "home partition" ext4 30GiB 100%
```


### 1.3 Format partitions
Each newly created partition must be formatted with the appropriate file system.
```
# mkfs.fat -F 32 /dev/sda1   <- The system boot partition
# mkfs.ext4 /dev/sda2        <- The root partition
# mkswap /dev/sda3           <- The swap partition
# mkfs.ext4 /dev/sda4        <- The home partition
```

### 1.4 Mount the file systems
Mount the root volume to `/mnt`.
```
# mount /dev/sda2 /mnt
```

Mount the system information partition.
```
# mount --mkdir /dev/sda1 /mnt/boot
```

Mount the remaining mount points.
```
# mount --mkdir /dev/sda4 /mnt/home
```

Enable the swap partition.
```
# swapon /dev/sda3
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

### 3.1 Install basic utilities
Install basics
```
# pacman -S vim man-db man-pages texinfo
```

Update all software and mirrors.
```
# pacman -Syyu
```


### 3.2  Set localtime.
```
# ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
# hwclock --systohc
```

### 3.3 Set the root password.
```
# passwd
```

### 3.4 Network Configuration
Start by setting the hostname of the machine:
```
# echo "vicarch" > /etc/hostname
```

And install a network manager. We will use NetworkManager:
```
# pacman -S networkmanager
# systemctl enable NetworkManager
```

### 3.5 AUR
We will need to install packages from the Arch User Repository (AUR), to do 
so we will use an AUR package manager called [yay](https://github.com/Jguer/yay).
We will install it in the `~/util` directory.

```
$ pacman -S --needed git base-devel
$ mkdir util; cd util
$ git clone https://aur.archlinux.org/yay.git
$ cd yay
$ makepkg -si
```


## 4. Bootloader Installation
All configurations will use GRUB as the bootloader.

 TODO: Choose and install a Linux-capable [boot loader](https://wiki.archlinux.org/title/Arch_boot_process#Boot_loader). If you have an Intel or AMD CPU, enable [microcode](https://wiki.archlinux.org/title/Microcode#Installation) updates in addition. 


## 5. User Management
First make a new user other than root, with a personal directory in `/home`.
```
# useradd -m vic
# passwd vic
```

Then install sudo to enable this user elevation of privileges.
```
# pacman -S sudo
```

And add the user to the sudoers. In particular add the following line to the end of `/etc/sudoers` file.
```
vic ALL=(ALL) ALL
```

## Next Steps
The following configuration steps are described in the [CONFIGURATION](CONFIGURATION.md) guide.
