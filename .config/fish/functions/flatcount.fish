function flatcount --description 'Counts how many flatpaks there are'
	printf "\n\033[36;1m[󰋼 INFO]\033[0m You have $(flatpak list | count) flatpaks\n" $argv
end
