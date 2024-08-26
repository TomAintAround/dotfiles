function flatcountapp --description 'Counts how many flatpak apps there are'
    printf "\n\033[36;1m[󰋼 INFO]\033[0m You have $(flatpak list --app | count) flatpak applications\n" $argv
end
