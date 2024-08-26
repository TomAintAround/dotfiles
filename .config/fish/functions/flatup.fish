function flatup --wraps='flatpak update' --description 'Update flatpaks'
    flatpak update $argv
end
