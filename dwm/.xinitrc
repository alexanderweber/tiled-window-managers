
while true; do

# Power/Battery Status
if [ "$( cat /sys/class/power_supply/AC0/online )" -eq "1" ]; then
        DWM_BATTERY="AC";
        DWM_RENEW_INT=3;
else
        DWM_BATTERY=$(( `cat /sys/class/power_supply/BAT0/energy_now` * 100 / `cat /sys/class/power_supply/BAT0/energy_full` ));
        DWM_RENEW_INT=30;
fi;

wifi(){
      STATUS="X`/sbin/iwgetid`"
      if test "$STATUS" != "X" ; then
        ESSID="`/sbin/iwgetid |awk -F ":" '{print $2}'|sed -e 's/"//g'`"
        LINK="`awk '/wlp4s0:/ {print $3}' /proc/net/wireless |sed -e 's/\.//g'`"
      echo "$ESSID:$LINK"
      fi
    }

# Keyboard layout
if [ "`xset -q | awk -F \" \" '/Group 2/ {print($4)}'`" = "on" ]; then 
		  DWM_LAYOUT="ru"; 
else 
		  DWM_LAYOUT="en"; 
fi; 

# Volume Level
DWM_VOL=$( amixer -c1 sget Master | awk -vORS=' ' '/Mono:/ {print($6$4)}' );

# Date and Time
DWM_CLOCK=$( date '+%e %b %Y %a | %k:%M' );

# Overall output command
DWM_STATUS="WiFi: [`wifi`] | Lang: [$DWM_LAYOUT] | Power: [$DWM_BATTERY] | Vol: $DWM_VOL | $DWM_CLOCK";
xsetroot -name "$DWM_STATUS";
sleep $DWM_RENEW_INT;

done &

# set your keyboard layout for your preferred language. 
setxkbmap -layout de

# Set wallpaper
feh --bg-center ~/Pictures/cat.jpg

#check if DP1-1 is connected
if (xrandr | grep "DP1-1 connected" > /dev/null)
then
 xrandr --output eDP1 --off
 xrandr --output DP1-2 --off
fi

xbindkeys

# Autostart section
exec dwm
