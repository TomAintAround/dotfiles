#!/usr/bin/env bash

draw() {
	path="$(readlink -f -- "$1" | sed 's/\\/\\\\/g;s/"/\\"/g')"
	printf '{"action":"add","identifier":"preview","x":%d,"y":%d,"width":%d,"height":%d,"scaler":"contain","scaling_position_x":0.5,"scaling_position_y":0.5,"path":"%s"}\n' \
	"$x" "$y" "$width" "$height" "$path" >"$FIFO_UEBERZUG"
	

	exit 1
}

hash() {
	cache="$HOME/.cache/lf/$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f -- "$1")" | sha256sum | cut -d' ' -f1).jpg"
}

cache() {
	if ! [ -f "$cache" ]; then
		dir="$(dirname -- "$cache")"
		[ -d "$dir" ] || mkdir -p -- "$dir"
		"$@"
	fi
	draw "$cache"
}
	

file="$1"
width="$2"
height="$3"
x="$4"
y="$5"

mime_preview() {
	case "$mime_type","$ran_guard" in
		image/*)
			if [ -p "$FIFO_UEBERZUG" ]; then
				# ueberzug doesn't handle image orientation correctly
				orientation="$(magick identify -format '%[orientation]\n' -- "${file[0]}")"
				if [ -n "$orientation" ] \
				&& [ "$orientation" != Undefined ] \
				&& [ "$orientation" != TopLeft ]; then
					hash "$file"
					cache magick -- "${file[0]}" -auto-orient "$cache".jpg
				else
					draw "$file"
				fi
			fi
	

		;;
		(video/webm,0)
			# file --mime-type doesn't distinguish well between "video/webm"
			# actual webm videos or webm audios, but exiftool does, thus
			# re-run this function with new mimetype
			mime_type="$(exiftool -s3 -MIMEType "$file")" \
			ran_guard=$((ran_guard+1))
			mime_preview "$@"
		;;
		video/*)
			if [ -p "$FIFO_UEBERZUG" ]; then
				hash "$file"
				cache ffmpegthumbnailer -i "$file" -o "$cache".jpg -s 0
			fi
	

		;;
		(text/html,0)
			lynx -width="$x" -display_charset=utf-8 -dump -- "$file"
		;;
		(text/troff,0)
			case "${file##*.}" in
			([0-9] | [01]p | [23]*)
				man ./ "$file" | col -b
			;;
			(*)
				bat --terminal-width "$(($x*7/9))" --style=numbers --paging=never "$file"
			esac
		;;
		(text/*,0 | */xml,0 | application/javascript,0 | application/x-subrip,0 )
			bat --terminal-width "$(($x*7/9))" --style=numbers --paging=never "$file"
		;;
		(application/json,0)
			jq -C < "$file"
		;;
		( application/x-pie-executable,0 | application/x-executable,0 | \
		application/x-sharedlib,0)
			objdump -d "$file" -M intel
			#readelf -WCa "$file"
			#hexdump -C "$file" || xxd "$file"
		;;
		(audio/*)
			exiftool -j "$file" | jq -C
		;;
		(*opendocument*,0) # .odt, .ods
			CCt='	' \
			bytes=$(du -sb "$file") bytes="${bytes%%"$CCt"*}"
			if [ "$bytes" -lt 150000 ]; then
				odt2txt "$file"
			else
				printf "file too big too preview quickly\n"
			fi
		;;
		(*ms-excel,0)  # .xls
			xls2csv -- "$file" \
				| bat --terminal-width "$(($x*7/9))" --color=always -l csv --style=numbers --paging=never
		;;
		(application/pgp-encrypted,0)
			printf "PGP armored ASCII \033[1;31mencrypted\033[m file,\ntry using gpg to decrypt it\n\n"
			cat "$file"
			gpg -d -- "$file"
		;;
		(application/octet-stream,0)
			#extension="${file##*.}" extension="${extension%"$file"}"
			case "${file##*.}" in
			(gpg)
				printf "OpenPGP \033[1;31mencrypted\033[m file,\ntry using gpg to decrypt it\n\n"
			;;
			(*) exiftool -j "$file" | jq -C
			esac
		;;
	esac

	ext="$(printf '%s' "$file" | tr '[:upper:]' '[:lower:]')"
	ext="${ext##*.}"
	case "$ext" in
		7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|\
		lha|lrz|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|\
		tbz2|tgz|tlz|txz|tZ|tzo|war|xz|Z|zip)
			als -- "$file"
		;;
	esac

	return 1
}

main() {
	mime_type="$(file --dereference -b --mime-type -- "$1")" \
	ran_guard=0
	mime_preview "$@" || return $?
}

main "$@" || exit $?
file -Lb -- "$file" | fold -s -w "$width"
