# -*- mode: shell-script -*-

# Original: http://petitviolet.hatenablog.com/entry/20140722/1406034439

###
### peco git
###

function peco-select-gitadd() {
    local SELECTED_FILE_TO_ADD="$(git status --porcelain | \
                                  peco --query "$LBUFFER" | \
                                  awk -F ' ' '{print $NF}')"
    if [ -n "$SELECTED_FILE_TO_ADD" ]; then
      BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
      CURSOR=$#BUFFER
    fi
    zle accept-line
    # zle clear-screen
}
zle -N peco-select-gitadd


function peco-git-branch-checkout () {
    local selected_branch_name="$(git branch -a | peco | sed 's/^\*/ /' | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        BUFFER=" git checkout ${selected_branch_name}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-branch-checkout


function peco-git-new-branch-with-base () {
    local selected_branch_name="$(git branch -a | peco | sed 's/^\*/ /' | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*-> *?(.*)$|\1|;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*?remotes/(.*)$|\1|;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        LBUFFER=" git checkout -b "
        RBUFFER=" ${selected_branch_name}"
    fi
    zle clear-screen
}
zle -N peco-git-new-branch-with-base


function peco-git-select-branch () {
    local selected_branch_name="$(git branch -a | peco | sed 's/^\*/ /' | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*-> *?(.*)$|\1|;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*?remotes/(.*)$|\1|;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        LBUFFER="$(echo ${LBUFFER} | sed -e 's/ *$//') ${selected_branch_name}"
        RBUFFER="${RBUFFER}"
    fi
    zle clear-screen
}
zle -N peco-git-select-branch
