#!/usr/bin/env bash

###################################################################################################################
# https://github.com/arcolinux/arcolinux-hyprland/blob/main/etc/skel/.config/hypr/scripts/changeLayout (modified) #
###################################################################################################################

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case "$LAYOUT" in
"master")
	hyprctl keyword general:layout dwindle
	notify-send --app-name="Layout change" "Dwindle Layout"
	;;
"dwindle")
	hyprctl keyword general:layout master
	notify-send --app-name="Layout change" "Master Layout"
	;;
*) ;;
esac
