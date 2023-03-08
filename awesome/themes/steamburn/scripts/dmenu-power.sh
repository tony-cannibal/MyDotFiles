#!/bin/bash

NB="#140c0b"
NF="#e2ccb0"
SB="#d88166"
SF=$NB
font="terminus-12"

function powermenu {

    options="Cancel\nShutdown\nReboot\nLogout"

    selected=$(echo -e $options | dmenu -p "Power Menu" -fn $font -sb $SB -sf $SF -nf $NF -nb $NB)

    if [[ $selected = "Shutdown" ]]; then
        poweroff

    elif [[ $selected = "Reboot" ]]; then
        reboot
    
    elif [[ $selected = "Logout" ]]; then
        #name=$(whoami)
        pkill -KILL -u $(whoami)
         

    elif [[ $selected = "Cancel" ]]; then
        return
    
    fi

}

powermenu
