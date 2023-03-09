#!/usr/bin/bash

layout=$(dkcmd status type=layout num=1)

if [ $layout = tile ]
then
    dkcmd set layout none
    polybar-msg action layout hook 0
fi


if [ $layout = none ]
then
    dkcmd set layout mono
    polybar-msg action layout hook 0
fi


if [ $layout = mono ]
then
    dkcmd set layout tile
    polybar-msg action layout hook 0
fi



