function flatsearins --wraps='flatpak list' --description 'Searches for an installed flatpak'
	flatpak list $argv
end
