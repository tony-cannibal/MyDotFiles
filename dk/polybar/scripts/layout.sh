#!/usr/bin/bash

layout=$(dkcmd status type=layout num=1)

case $layout in 

    tile)
        echo "[]="
        ;;
    mono)
        echo "[M]"
        ;;
    none)
        echo "><>"
        ;;
    grid)
        echo "###"
        ;;
    spiral)
        echo "(@)"
        ;;
    dwindle)
        echo "[\\]"
        ;;
    tstack)
        echo "F^F"
        ;;
    *)
        echo "Error"
esac

