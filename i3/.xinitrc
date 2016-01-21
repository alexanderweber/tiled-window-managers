# check if DP1-1 is connected
if (xrandr | grep "DP-1-1 connected" > /dev/null)
then
 xrandr --output eDP-1 --off
 xrandr --output DP-1-2 --off
fi

# set german layout
setxkbmap de

# start i3
exec i3
