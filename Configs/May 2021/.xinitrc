exec i3
xss-lock -- xdotool key Alt+Ctrl+C &
exec xidlehook --not-when-audio --timer 360 "xdotool key Alt+Ctrl+C" &
