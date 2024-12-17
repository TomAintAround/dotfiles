if status --is-interactive
	# tmux
	for sessions in (tmux list-sessions | command grep -v "(attached)\|keep" | sed 's/:.*$//')
	tmux kill-session -t "$sessions"
	end

	if not set -q TMUX
		tmux list-sessions | command grep -v "(attached)" &>/dev/null
		and exec tmux attach
		or exec tmux
	end
end
