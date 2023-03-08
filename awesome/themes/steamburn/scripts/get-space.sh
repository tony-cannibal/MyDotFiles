#!/usr/bin/bash



free=$(df -h / | tail -n 1 | awk '{print $4 }')


echo "$free"

