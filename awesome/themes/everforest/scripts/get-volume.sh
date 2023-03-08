#!/usr/bin/bash

VOL="$(pamixer --get-volume-human)"

if [ $VOL == "muted" ]
then
    echo "200"
else
    echo ${VOL:0:-1}
fi
