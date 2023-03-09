#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi, iostat.
# Tested on: Debian 10, Fedora 31.

PANEL_FIFO=/tmp/panel-fifo

# Check for a pre existing fifo file if found it deletes it 
# Then it creates a new empty one
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

# Get First Print of Volume
# echo "V$(amixer sget Master | tail -n 1 | awk '{print $4}' | tr -d "[]")" > "$PANEL_FIFO" &
echo "V$(pamixer --get-volume-human)" > "$PANEL_FIFO" &

# Get Hdd Free Space
while true ; do
    echo "H$(df -h /home | tail -n 1 | awk '{print $4}')"
    sleep 10
done > "$PANEL_FIFO" &

# Ram Info
while true ; do 
    printf "R%s\n" $(free -h | sed -n '2p' | awk '{print $3"/"$2}' | sed 's/i//g')
    sleep 2
done > "$PANEL_FIFO" &


# This is The parser that read every line from the fifo file
# to update de infomation printed out
while read -r line ; do
	case $line in
		V*)
			# Volume Output 
            vol="VOL:${line#?}"
			;;
		H*)
			# Hard Drive 
            hdd="HDD:${line#?}"
			;;
		R*)
			# Ram Output 
            ram="RAM:${line#?}"
			;;
    esac
    echo "[ ${vol} ] [ ${hdd} ] [ ${ram} ]"
done < "$PANEL_FIFO" &
