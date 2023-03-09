#!/usr/bin/bash

# Disable Screen Sleep
xset s off -dpms

# Swap Escape With CapsLock
setxkbmap -option caps:swapescape

feh --bg-fill ~/Pictures/Wallpapers/Matrix/digital-skull.jpg &

# Polkit Agent
lxpolkit &

# Automount Drives
udiskie &

# Compositor
picom &

# Music Server
mpd &
