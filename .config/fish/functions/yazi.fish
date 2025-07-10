function yazi --description "Open yazi and change directory"
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]

        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
