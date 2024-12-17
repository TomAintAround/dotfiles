function flatcountrun --description 'Counts how many flatpak runtimes there are'
	printf "\n\033[36;1m[󰋼 INFO]\033[0m You have $(flatpak list --runtime | count) flatpak runtimes\n" $argv
end
