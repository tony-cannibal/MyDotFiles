#!/usr/bin/bash


total=$(free | grep Mem: | awk '{print $2}' | sed 's/Gi//')

used=$(free | grep Mem: | awk '{print $3}' | sed 's/Gi//')


mem=$(free -h | grep Mem: | awk '{print $3"/"$2}' | sed 's/i//g')


echo "$mem"

