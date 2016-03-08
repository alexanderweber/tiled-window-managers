# check if DP1-1 is connected
if (xrandr | grep "DP1-1 connected" > /dev/null)
then
 xrandr --output eDP1 --off
 xrandr --output DP1-2 --off
 cp ~/.asoundrc-usb ~/.asoundrc
fi

# set german layout
setxkbmap de

# start i3
exec i3
