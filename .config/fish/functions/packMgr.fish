function fzfSelect
    command printf "%s\n" $argv | command fzf \
        --preview "" \
        --tmux right,30
end

function nixOS
    if test "$argv[2]" = Rebuild
        command nh os switch --ask /etc/nixos
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = "Rebuild and upgrade"
        command sudo nix flake update --flake /etc/nixos
        command nh os switch --ask /etc/nixos
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = Search
        commandline "nh search "
        return 1
    end

    if test "$argv[2]" = Clean
        command nh clean
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = Cancel
        return 1
    end

    set -l list Rebuild "Rebuild and upgrade" Search Clean Cancel
    set -l selection (fzfSelect $list)
    packMgr $argv $selection
end

function homeManager
    if test "$argv[2]" = Rebuild
        command nh home switch --ask "$XDG_CONFIG_HOME"/home-manager
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = "Rebuild and upgrade"
        command nh home switch --ask --update "$XDG_CONFIG_HOME"/home-manager
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = Cancel
        return 1
    end

    set -l list Rebuild "Rebuild and upgrade" Cancel
    set -l selection (fzfSelect $list)
    packMgr $argv $selection
end

function flatpak
    if test "$argv[2]" = Update
        flatup
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = Install
        commandline "flatins "
        return 1
    end

    if test "$argv[2]" = Clean
        # This one in particular needs to be done like this,
        # because the other way wouldn't let me press enter
        commandline flatclean
        and commandline -f execute
        return 1
    end

    if test "$argv[2]" = Count
        flatcount
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = "Count apps"
        flatcountapp
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = "Count runtimes"
        flatcountrun
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = "Package information"
        commandline "flatinfo "
        return 1
    end

    if test "$argv[2]" = Kill
        commandline "flatkill "
        return 1
    end

    if test "$argv[2]" = List
        flatlist
        commandline -f execute
        return 1
    end

    if test "$argv[2]" = Uninstall
        commandline "flatrem "
        return 1
    end

    if test "$argv[2]" = Run
        commandline "flatrun "
        return 1
    end

    if test "$argv[2]" = Search
        commandline "flatsear "
        return 1
    end

    if test "$argv[2]" = Cancel
        return 1
    end

    set -l list \
        Update \
        Install \
        Clean \
        Count \
        "Count apps" \
        "Count runtimes" \
        "Package information" \
        Kill \
        List \
        Uninstall \
        Run \
        Search \
        Cancel
    set -l selection (fzfSelect $list)
    packMgr $argv $selection
end

function packMgr --description="Package manager for NixOS and Flatpak"
    if test "$argv[1]" = NixOS
        nixOS $argv
        return 1
    end

    if test "$argv[1]" = Home-Manager
        homeManager $argv
        return 1
    end

    if test "$argv[1]" = Flatpak
        flatpak $argv
        return 1
    end

    if test "$argv[1]" = Cancel
        return 1
    end

    set -l initialList NixOS Home-Manager Flatpak Cancel
    set -l selection (fzfSelect $initialList)
    packMgr $selection
end
