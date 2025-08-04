function flatclean --wraps='flatpak uninstall --unused' --description 'Removes orphaned flatpaks'
    flatpak uninstall --unused
end
