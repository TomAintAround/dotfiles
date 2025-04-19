if status is-interactive
    # Tmux
    set tmuxSession default
    if ! tmux has-session -t $tmuxSession 2>/dev/null
        tmux new-session -d -s $tmuxSession
    end
    tmux attach-session -t $tmuxSession 2>/dev/null
end
