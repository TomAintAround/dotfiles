# XDG
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state

# Default Apps
set -gx OPENER xdg-open
set -gx VISUAl nvim
set -gx EDITOR nvim
set -gx PAGER "bat --paging=always"
set -gx TERMINAL alacritty
set -gx READER "libreoffice --draw"
set -gx BROWSER librewolf
set -gx IMAGE_EDITOR gimp
set -gx AUDIO_PLAYER vlc
set -gx VIDEO_PLAYER vlc
set -gx FILE_MANAGER yazi

# Paths
set -gx GOPATH "$XDG_DATA_HOME"/go
set -gx WINEPREFIX XDG_DATA_HOME/wine

# Fixes
set -gx ELECTRON_OZONE_PLATFORM_HINT auto

# Themes
set -gx GTK_THEME (cat "$HOME"/.config/gtk-3.0/settings.ini | grep gtk-theme-name= | sed 's/.*=//'):dark
set -gx ICON_THEME (cat "$HOME"/.config/gtk-3.0/settings.ini | grep gtk-icon-theme-name= | sed 's/.*=//')
set -gx HYPRCURSOR_THEME hypr_Bibata-Modern-Ice
set -gx HYPRCURSOR_SIZE 20
set -gx KRITA_NO_STYLE_OVERRIDE 1

# FZF
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS " \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4 \
--ansi --layout reverse --tmux 80% --preview-label ' Preview ' \
--preview-window 'right:60%' \
--preview 'bat --paging=never --color=always --wrap=never --style=header,grid,numbers --line-range :50 {}'"
set -gx FZF_CTRL_T_COMMAND "fd --type f"
set -gx FZF_CTRL_T_OPTS " \
    --border-label ' Select a file to be pasted into the command line '"
set -gx FZF_ALT_C_COMMAND "fd --type d"
set -gx FZF_ALT_C_OPTS " \
    --border-label ' Select a directory to navigate to ' \
    --preview 'eza --git --icons=always --long --all --group --header --links --color=always --no-quotes --smart-group --group-directories-first --time-style=\'+%H:%m_%d/%m/%y\' {} | head -n 50'"
set -gx FZF_CTRL_R_OPTS " \
    --border-label ' Select a command to be pasted into the command line ' \
    --preview-window '0%'"
