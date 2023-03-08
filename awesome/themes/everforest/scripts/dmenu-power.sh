#!/bin/bash

function powermenu {

    options="Cancel\nShutdown\nReboot\nLogout"

    selected=$(echo -e $options | dmenu -p "Power Menu" -fn "terminus-12" -sb '#a7c080' -sf "#272e33" -nb '#272e33')

    if [[ $selected = "Shutdown" ]]; then
        systemctl poweroff
        # loginctl poweroff

    elif [[ $selected = "Reboot" ]]; then
        systemctl reboot
        # loginctl reboot
    
    elif [[ $selected = "Logout" ]]; then
        pkill awesome
        exit

    elif [[ $selected = "Cancel" ]]; then
        return
    
    fi

}

powermenu
