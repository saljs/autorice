#!/bin/bash

readarray colors < <(~/.scripts/imgscheme.py $1)
clist="ColorPalette=${colors[0]};${colors[1]};${colors[2]};${colors[3]};${colors[4]};${colors[5]};${colors[6]};${colors[7]};${colors[8]};${colors[9]};${colors[10]};${colors[11]};${colors[12]};${colors[13]};${colors[14]};${colors[15]};"
clist=$(echo $clist | tr -d " ")

#update term colorscheme
sed -i "s/ColorPalette.*/$clist/g" ~/.config/xfce4/terminal/terminalrc

#update wm theme
black=$(echo ${colors[0]} |tr -d " ")
red=$(echo ${colors[1]} |tr -d " ")
green=$(echo ${colors[2]} |tr -d " ")
brown=$(echo ${colors[3]} |tr -d " ")
blue=$(echo ${colors[4]} |tr -d " ")
magenta=$(echo ${colors[5]} |tr -d " ")
cyan=$(echo ${colors[6]} |tr -d " ")
light_grey=$(echo ${colors[7]} |tr -d " ")
dark_grey=$(echo ${colors[8]} |tr -d " ")
light_red=$(echo ${colors[9]} |tr -d " ")
light_green=$(echo ${colors[10]} |tr -d " ")
yellow=$(echo ${colors[11]} |tr -d " ")
light_blue=$(echo ${colors[12]} |tr -d " ")
light_magenta=$(echo ${colors[13]} |tr -d " ")
light_cyan=$(echo ${colors[14]} |tr -d " ")
white=$(echo ${colors[15]} |tr -d " ")

sed -i "s/separator.*/separator\ $light_grey/g" ~/.i3/config
sed -i "s/background.*/background\ #2F343F/g" ~/.i3/config
sed -i "s/statusline.*/statusline\ $white/g" ~/.i3/config
sed -i "s/focused_workspace.*/focused_workspace\ $light_blue\ $light_blue\ $white/g" ~/.i3/config
sed -i "s/active_workspace.*/active_workspace\ #2F343F\ #2F343F\ $light_grey/g" ~/.i3/config
sed -i "s/inactive_workspace.*/inactive_workspace\ #2F343F\ #2F343F\ $white/g" ~/.i3/config
sed -i "s/urgent_workspace.*/urgent_workspace\ #2F343F\ $red\ #2F343F/g" ~/.i3/config

sed -i "s/client\.focused.*/client\.focused\ $light_blue\ $light_blue\ $white\ #2F343F/g" ~/.i3/config
sed -i "s/client\.focused_inactive.*/client\.focused_inactive\ #2F343F\ #2F343F\ $brown\ #2F343F/g" ~/.i3/config
sed -i "s/client\.unfocused.*/client\.unfocused\ #2F343F\ #2F343F\ $light_grey\ #2F343F/g" ~/.i3/config
sed -i "s/client\.urgent.*/client\.urgent\ $red\ $red\ #2F343F\ $light_red/g" ~/.i3/config

sed -i "s/color_good.*/color_good\ =\ \"$white\"/g" ~/.i3status.conf
sed -i "s/color_degraded.*/color_degraded\ =\ \"$light_red\"/g" ~/.i3status.conf
sed -i "s/color_bad.*/color_bad\ =\ \"$light_red\"/g" ~/.i3status.conf

#theme rofi
sed -i "s/rofi\.color-normal:.*/rofi\.color-normal:\ #2F343F,\ $white,\ #2F343F,\ #2F343F,\ $light_blue/g" ~/.config/rofi/config
sed -i "s/rofi\.color-urgent:.*/rofi\.color-urgent:\ #2F343F,\ $red,\ #2F343F,\ #2F343F,\ $light_blue/g" ~/.config/rofi/config
sed -i "s/rofi\.color-active:.*/rofi\.color-active:\ #2F343F,\ $light_red\ #2F343F,\ #2F343F,\ $light_blue/g" ~/.config/rofi/config
sed -i "s/rofi\.color-window:.*/rofi\.color-window:\ #2F343F/g" ~/.config/rofi/config

feh  --bg-scale $1
i3-msg reload
i3-msg restart
