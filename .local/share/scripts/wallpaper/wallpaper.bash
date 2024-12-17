#!/usr/bin/env bash

selected=$(cat $XDG_DATA_HOME/scripts/wallpaper/wallpaper-set)
selected="${selected:-1}"
wallpapersDir="$XDG_PICTURES_DIR"/Wallpapers

mode() {
	if [[ $1 =~ ^[0-9]+$ ]] && [[ $(ls $wallpapersDir | grep -ow "$1") ]]; then
		new="$1"
		printf "\033[0;32m[MODE]\033[0m Direct\n"
	elif [[ "$1" = "startup" ]]; then
		new=$selected
	else
		wallpapernum=$(ls $wallpapersDir | wc -l)
		new="$(($selected + 1))"
		if [ "$new" -gt "$wallpapernum" ]; then
			new=1
		fi
		printf "\033[0;32m[MODE]\033[0m Cycle\n"
	fi
}

wayland() {
	mode "$1"
	if [[ $(ps -ef | grep swww-daemon | sed '/grep/d' | cat -s) ]]; then
		printf "\033[0;32m[INFO]\033[0m Selecting wallpaper $new.jpg\n"
		swww img $wallpapersDir/"$new".jpg --transition-step 150 --transition-type wipe --transition-bezier .33,1,.67,1
	else
		printf "\033[0;32m[INFO]\033[0m Initializing SWWW and selecting wallpaper $new.jpg\n"
		swww-daemon &
		swww img $wallpapersDir/"$new".jpg
	fi
}

case "$XDG_SESSION_TYPE" in
	"wayland")
		wayland "$1"
		;;

	*)
		mode "$1"
		printf "\033[0;32m[INFO]\033[0m Selecting wallpaper $new.jpg\n"
		feh --bg-fill $wallpapersDir/"$new".jpg
esac

echo "$new" > "$XDG_DATA_HOME"/scripts/wallpaper/wallpaper-set
