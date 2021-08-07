feh --bg-scale Downloads/wallhaven1.jpg
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec i3
