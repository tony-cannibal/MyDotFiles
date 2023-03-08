#!/usr/bin/bash


free=$(df -h /home | tail -n 1 | awk '{print $4}')

echo "$free"

