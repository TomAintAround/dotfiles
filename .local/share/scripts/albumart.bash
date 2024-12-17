#!/usr/bin/env bash

##########################################################################
# https://github.com/VishnuSanal/dotfiles/blob/main/bin/mpd-album-art.sh #
##########################################################################

THUMB="/tmp/mpdAlbumArt.jpg"

while true; do
	if [ $(mpc status %state%) == "playing" ]; then
		FILE="$HOME/Music/$(mpc current -f %file%)"
	fi
	echo "$FILE"
	ffmpeg -i "$FILE" "$THUMB" -y &> /dev/null
	mpc idle player
done
