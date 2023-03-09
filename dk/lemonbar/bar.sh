#!/bin/bash
# shellcheck disable=SC2059,SC2064,SC2086

# simple lightweight lemonbar script for use with dk
source $HOME/.cache/wal/bash.sh

bg=$background
fg=$foreground
highlight=$accent
underline=3
separator="|"
# separator="┃"

# xfonts
# font0="-xos4-terminus-medium-r-normal--12-240-72-72-c-120-iso10646-1"
# font1=""
# font2=""
# font3=""

# xft fonts
font0="TerminessTTF Nerd Font:size=9"
# font0="BigBlue_Terminal_437TT Nerd Font:size=9"
# font0="JetBrainsMono Nerd Font:size=9"
# font1="Font Awesome 5 Brands:pixelsize=20"
# font2="icomoon:pixelsize=18"
# font3="Anonymice Nerd Font Mono:pixelsize=18"

fifo="/tmp/bar.fifo"

# mimic dwm style layout symbols
typeset -A layouts=(
[tile]="[]="
[mono]="[M]"
[none]="><>"
[grid]="###"
[spiral]="(@)"
[dwindle]="[\\]"
[tstack]="F^F"
)

clock()
{
	if [[ $1 ]]; then
		while :; do
			date +"T%%{A1:$1:} %a %H:%M %%{A}"
			sleep 10
		done
	else
		while :; do
			date +"T%%{F$fg} %a %H:%M %%{F-}"
			sleep 10
		done
	fi
}

battery()
{
	if [[ $1 ]]; then
		while :; do
			printf 'B%s\n' "%{A1:$1:} $(acpi --battery 2>/dev/null | cut -d, -f2 | tr -d '[:space:]') %{A}"
			sleep 10
		done
	else
		while :; do
			printf 'B%s\n' " $(acpi --battery 2>/dev/null | cut -d, -f2 | tr -d '[:space:]') "
			sleep 10
		done
	fi
}

volume()
{
	if [[ $1 ]]; then
		while :; do
			printf 'V%s\n' "%{A1:$1:} $(pamixer --get-volume-human) %{A}"
			sleep 0.2
		done
	else
		while :; do
			printf 'V%s\n' "%{F$fg} $(pamixer --get-volume-human) %{F-}"
			sleep 0.2
		done
	fi
}

memory() 
{
    while :; do
        printf 'R%s\n' " $(free -h | sed -n '2p' | awk '{print $3"/"$2}' | sed 's/i//g') "
        sleep 2
    done
}

disk()
{
    while :; do
        printf 'H%s\n' " $(df -h /home | tail -n 1 | awk '{print $4}') "
        sleep 5
    done
}

parsefifo()
{
	typeset f='' b='' u='' wm='' time='' bat='' vol='' title='' layout='' s="$separator" memory=''

	while read -r line; do
		case $line in
			T*)
                time=" %{F$highlight}%{F-}${line#?}"
                ;;
            R*)
                memory=" %{F$highlight}%{F-}${line#?}"
                ;;
			V*)
                vol=" %{F$highlight}%{F-}${line#?}"
                ;;
			B*)
                bat="${line#?}"
                ;;
			A*)
                window=${line#?}
                title="${window: :40}"
                ;;
			L*)
                l="${line#?}"; layout="${layouts[$l]}"
                ;;
            H*)
                disk=" %{F$highlight}%{F-}${line#?}"
                ;;

			W*)
				wm='' IFS=':' # set the internal field separator to ':'
				set -- ${line#?}  # split the line into arguments ($@) based on the field separator
				for item in "$@"; do
					name=${item#?}
					case $item in
						A*) f="$highlight" b="$bg" u="$highlight" ;; # occupied   - focused
						a*) f="$fg"        b="$bg" u="$highlight" ;; # occupied   - unfocused
						I*) f="$highlight" b="$bg" u="$fg"        ;; # unoccupied - focused
						i*) f="$fg"        b="$bg" u="$fg"        ;; # unoccupied - unfocused
					esac
					wm="$wm%{F$f}%{B$b}%{+u}%{U$u}%{A:dkcmd ws $name:} $name %{A}%{-u}%{B-}%{F-}"
				done
				;;
		esac
		printf "%s\n" "%{l}$wm $s $layout%{c}$title%{r}${disk}${s}${memory}${s}${vol}${s}${time}"
	done
}


# kill the process and cleanup if we exit or get killed
trap "trap - TERM; kill 0; rm -f '$fifo'" INT TERM QUIT EXIT

# make the fifo
[ -e "$fifo" ] && rm "$fifo"
mkfifo "$fifo"


# here we dump info into the FIFO, order does not matter things are parsed
# out using the first character of the line. Click commands for left button
# can be added by passing an argument containing the command (like volume below)
clock '' > "$fifo" &
battery '' > "$fifo" &
volume 'pavucontrol' > "$fifo" &
dkcmd status type=bar > "$fifo" &
memory > "$fifo" &
disk > "$fifo" &


# run the pipeline
if [[ $1 == '-b' ]]; then
	parsefifo < "$fifo" | lemonbar -b -a 32 -u $underline -B "$bg" -F "$fg" -f "$font0" -f "$font1" -f "$font2" -f "$font3" | sh
else
	# parsefifo < "$fifo" | lemonbar -a 32 -u $underline -B "$bg" -F "$fg" -f "$font0" -f "$font1" -f "$font2" -f "$font3" | sh
	parsefifo < "$fifo" | lemonbar -a 32 -u $underline -B "$bg" -F "$fg" -f "$font0" | sh
fi

# vim:ft=sh:fdm=marker:fmr={,}
