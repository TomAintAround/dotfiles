function flatrem --wraps='flatpak uninstall' --description 'Uninstalls a flatpak'
	flatpak uninstall $argv
end
