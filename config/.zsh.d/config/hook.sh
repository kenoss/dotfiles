if [ -n "$TMUX" ]; then
  function refresh-tmux-environment-variables {
    export $(tmux show-environment | grep "^DISPLAY")
    export $(tmux show-environment | grep "^SSH_AGENT_PID")
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
  }
else
  function refresh-tmux-environment-variables {}
fi

function preexec {
    refresh-tmux-environment-variables
}
