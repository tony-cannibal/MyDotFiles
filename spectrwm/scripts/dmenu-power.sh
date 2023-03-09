#!/bin/bash

function powermenu {

    options="Cancel\nShutdown\nReboot\nLogout"

    selected=$(echo -e $options | dmenu -p "Power Menu" -fn "terminus-10" -sf '#000000' -sb '#005500' -nf '#005500' -nb '#000000')

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
