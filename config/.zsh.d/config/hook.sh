if [ -n "$TMUX" ]; then
  function refresh-tmux-environment-variables-aux {
    export $(tmux show-environment | grep "^DISPLAY")
    export $(tmux show-environment | grep "^SSH_AGENT_PID")
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
  }

  function refresh-tmux-environment-variables {
    refresh-tmux-environment-variables-aux >/dev/null
  }
else
  function refresh-tmux-environment-variables {}
fi

function preexec {
    refresh-tmux-environment-variables
}
