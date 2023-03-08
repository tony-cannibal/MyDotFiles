#!/usr/bin/bash


total=$(free | grep Mem: | awk '{print $2}' | sed 's/Gi//')

used=$(free | grep Mem: | awk '{print $3}' | sed 's/Gi//')



result=$( awk '{OFMT = "%2.2f";print $1 / $2}' <<< "$used $total")

echo "$result"

