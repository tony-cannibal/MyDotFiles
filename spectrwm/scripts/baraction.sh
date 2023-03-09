#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi, iostat.
# Tested on: Debian 10, Fedora 31.
#

print_date() {
	# The date is printed to the status bar by default.
	# To print the date through this script, set clock_enabled to 0
	# in spectrwm.conf.  Uncomment "print_date" below.
	FORMAT="%a %b %d %R %Z %Y"
	DATE=`date "+${FORMAT}"`
	echo -n "${DATE}     "
}

print_vol() {
 echo -n "VOL:$(amixer sget Master | tail -n 1 | awk '{print $4}' | tr -d "[]")"
}


print_hdd() {
    echo -n "HDD:$(df -h /home | tail -n 1 | awk '{print $4}')"
}


print_ram() {
     echo -n "RAM:$(free -h | sed -n '2p' | awk '{print $3"/"$2}' | sed 's/i//g')"
}


while :; do
    echo "[ $(print_vol) ] [ $(print_hdd) ] [ $(print_ram) ]"
	sleep 0.5
done
