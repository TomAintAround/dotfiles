function flatclean --wraps='flatpak uninstall --unused' --description 'Removes orphaned flatpaks'
	flatpak uninstall --unused | grep "Nothing unused to uninstall" >/dev/null
	and printf "\n\033[31;1m[ ERROR]\033[0m Nothing to uninstall\n"
	or flatpak uninstall --unused $argv
end
