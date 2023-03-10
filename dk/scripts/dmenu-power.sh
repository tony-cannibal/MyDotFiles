#!/bin/bash



function powermenu {

    options="Cancel\nShutdown\nReboot\nLogout"

    selected=$(echo -e $options | dmenu -p "Power Menu" -fn "terminus-13" )

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
