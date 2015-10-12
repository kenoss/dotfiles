alias histgrep='history 1 | grep'

function histgrepuniq() {
    histgrep $1 | sed 's/^ *[0-9]* */  /' | sort -u
}

alias hisg='histgrep'
alias hisgu='histgrepuniq'

function hisgl() {
    histgrep $1 | $PAGER
}
