# Greeting
set fish_greeting ""

# Vi Mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Keybindings
bind \cf 'commandline -f kill-whole-line && $FILE_MANAGER && commandline -f execute'
bind -M insert \ef 'commandline -f kill-whole-line && $FILE_MANAGER && commandline -f execute'
bind -M visual \ef 'commandline -f kill-whole-line && $FILE_MANAGER && commandline -f execute'
bind \ce 'commandline -f kill-whole-line && $EDITOR . && commandline -f execute'
bind -M insert \ce 'commandline -f kill-whole-line && $EDITOR . && commandline -f execute'
bind -M visual \ce 'commandline -f kill-whole-line && $EDITOR . && commandline -f execute'
bind \cp 'commandline -f kill-whole-line && packMgr . && commandline -f execute'
bind -M insert \cp 'commandline -f kill-whole-line && packMgr . && commandline -f execute'
bind -M visual \cp 'commandline -f kill-whole-line && packMgr . && commandline -f execute'

# Done Plugin
set -a __done_exclude '^pgrep'
