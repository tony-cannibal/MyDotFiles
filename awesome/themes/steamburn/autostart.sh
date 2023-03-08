#!/usr/bin/bash


setxkbmap -option caps:swapescape

xset s off -dpms

if ! pidof -x "lxpolkit" > /dev/null
then
    lxpolkit &
fi

if ! pidof -x "udiskie" > /dev/null
then
    udiskie &
fi

if ! pidof -x "mpd" > /dev/null
then
    mpd &
fi

if ! pidof -x "picom" > /dev/null
then
    picom --config ~/.config/awesome/themes/steamburn/picom/picom.conf &
fi

wmname LG3D

alacritty-themes "Baskerville - Count Von Count"
