function flatins --wraps='flatpak install flathub' --description 'Installs a flatpak'
	flatpak install flathub $argv
end
