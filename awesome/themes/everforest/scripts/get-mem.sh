#!/usr/bin/bash


mem=$(free -h | grep Mem: | awk '{print $3"/"$2}' | sed 's/i//g')

echo "$mem"

