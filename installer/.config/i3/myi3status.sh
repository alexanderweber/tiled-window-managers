#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
        read line
	[ "$(ls -A ~/tc)" ] && echo " | $line" || echo "$line" || exit 1
done

