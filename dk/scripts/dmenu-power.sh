#!/bin/bash

background='#001e27'
accent='#2176c7'

function powermenu {

    options="Cancel\nShutdown\nReboot\nLogout"

    selected=$(echo -e $options | dmenu -p "Power Menu" -fn "terminus-13" -nb $background -sb $accent -sf $background)

    if [[ $selected = "Shutdown" ]]; then
        systemctl poweroff

    elif [[ $selected = "Reboot" ]]; then
        systemctl reboot

    elif [[ $selected = "Logout" ]]; then
        #name=$(whoami)
        pkill -KILL -u $(whoami)

    elif [[ $selected = "Cancel" ]]; then
        return

    fi

}

powermenu
