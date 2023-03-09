#!/bin/bash

source $HOME/.cache/wal/bash.sh

function powermenu {

    options="Cancel\nShutdown\nReboot\nLogout"

    selected=$(echo -e $options | dmenu -p "Power Menu" -fn "terminus-13" -nb $background -sb $accent )

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
