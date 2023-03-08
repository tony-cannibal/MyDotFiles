#!/usr/bin/bash


total=$(df / | tail -n 1 | awk '{print $2}' | sed 's/G//')

used=$(df / | tail -n 1 | awk '{print $3}' | sed 's/G//')



result=$(awk '{OFMT = "%2.2f";print $1 / $2}' <<< "$used $total")

echo "$result"

