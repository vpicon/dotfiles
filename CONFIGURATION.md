# Configuration
This file consists of the system configuration post-installation.
It is based on the [General recomendations](https://wiki.archlinux.org/title/General_recommendations) 
article from the Arch installation documentation.


## 0. Basic Utils
### Network Utils
Installation of:
- ssh, scp
- wget

```
$ sudo pacman -S openssh wget
```


## 1. Graphical User Interface
### 1.1 Xorg Display Server
Install `Xorg` as the display server.
```
$ sudo pacman -S xorg-server xterm
```

#### 1.1.1 Monitor Settings
Check the current used resolution with the `xrandr` X extension:
```
$ xrandr
```
It will show the connected displays, for example:
```
Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
HDMI-3 connected 1920x1080 ...
```

If we would want to switch to 2560x1440 for example, we need to change the mode of xrandr:
```
$ xrandr --output HDMI-3 --mode 2560x1440_60.00 --verbose
```

It may fail due to no such display mode. We need to add this new mode to xrandr. We get all
the specs of this new mode with the command `cvt`.
```
$ cvt 2560 1440
# 2560x1440 59.96 Hz (CVT 3.69M9) hsync: 89.52 kHzl; pclk: 312.25 MHz
Modeline "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493  -hsync +vsync
```

Then add the mode with and set the display to this new mode.
```
$ xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493  -hsync +vsync
$ xrandr --addmode "2560x1440_60.00"
$ xrandr --ouptut HDMI-3 --mode "2560x1440_60.00"
```


### 1.2 Display Manager
The display manager is displayed at the end of the boot process in place of the default shell.
It is used [ly](https://github.com/fairyglade/ly). Install it by:
```
$ yay -S ly
$ sudo systemctl enable ly.service
```

#### Xinit (No Display Manager)
Optionally, if no display manager is desired, and we could use [xinit](https://wiki.archlinux.org/title/Xinit)
to script the start the X server. First install it:
```
$ sudo pacman -S xorg-xinit
```

Then add configure the personal `.xinitrc` file.
```
$ cp /etc/X11/xinit/xinitrc ~/.xinitrc
$ echo "exec i3" >> ~/.xinitrc
```

To start the xserver after starting, add this in your `~/.bash_profile`:
```
if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
    startx
fi
```

### 1.3 Window Manager
Instead of using a desktop environment, we use a simpler (but more effective)
and tiling window manager, [i3](https://wiki.archlinux.org/title/I3).
```
$ sudo pacman -S i3-gaps i3blocks i3status
```
Start by reading the [user guide](https://i3wm.org/docs/userguide.html#_exiting_i3).


### 1.4 Terminal Emulator
The [urxvt](https://wiki.archlinux.org/title/rxvt-unicode) terminal emulator
is used. Install the truecolor (24-bit colors) version.
```
$ yay -S rxvt-unicode-truecolor
```

### 1.5 Basic GUI Config Utils
#### Application Launcher
Install `rofi` for a menu to launch applications quickly from i3.
```
$ sudo pacman -S rofi 
```

#### Background Setter
Install a background setter for X window.
```
$ sudo pacman -S feh
```

We will store the background wallpaper into the file (or symbolic link) stored
at `.dotfiles/wallpapers/bg`. And so, add execution of `feh` from i3 in its config file.
```
exec_always feg --bg_scale $HOME/.dotfiles/wallpapers/bg
```

#### Status Bar
Install a easier to use and configure status bar for i3, `polybar`.
```
$ sudo pacman -S polybar
```

Then, we will use the launch script in the `.config/polybar/launch.sh` to start the program
at the beginning of i3. Add the following line to the i3 config file.
```
exec_always --no-startup-id $HOME/.config/polybar/launch.sh
```

And comment out the i3bar display in the i3 config file:
```bash
# bar {
#     status_command i3status
# }
```


## 2. Multimedia
### 2.1 Audio
TODO
