# -*- mode: shell-script -*-

###
### Auxiliary
###

function git-repository-url () {
    git remote -v | grep origin | grep fetch | gsed -r -e 's|^origin\t+(ssh://)?git@(.*)(:?.git)? .*$|\2|' | (read host; echo https://$host)
}

function peco-git-select-branch-internal () {
    local command
    if [ -n "$1" ]; then
        command="$1"
    else
        command='git branch -a'
    fi
    local selected_branch_name=$(eval $command | peco | awk '{ gsub(/remotes\//, "", $NF); print $NF }')
    echo "$selected_branch_name"
}



###
### peco git
###

function peco-git-insert-branch-to-buffer () {
    local selected_branch_name=$(peco-git-select-branch-internal)
    if [ -n "$selected_branch_name" ]; then
        LBUFFER="${LBUFFER% } ${selected_branch_name}"
    fi
}
zle -N peco-git-insert-branch-to-buffer

function peco-git-compare-branch-url () {
    local selected_start_branch_name=$(peco-git-select-branch-internal)
    if [ -z "$selected_start_branch_name" ]; then return; fi
    local selected_end_branch_name=$(peco-git-select-branch-internal)
    if [ -z "$selected_end_branch_name" ]; then return; fi
    local url=$(git-repository-url)
    echo "$url/compare/$selected_start_branch_name...$selected_end_branch_name"
}

function peco-git-merge-commit-url () {
    local prid=$(git log --all --grep 'Merge pull request' --date=short --decorate=short \
                     --pretty=format:'%C(yellow)%h %C(reset)%cd %C(blue)%cn %C(red)%d %C(reset)%s' |
                        peco |
                        gsed -r -e 's/^.* #([0-9]+) .*$/\1/')
    local url=$(git-repository-url)
    echo "$url/pull/$prid"
}

function peco-git-insert-modified-files-to-buffer () {
    local selected_files=$(git status --short | peco --prompt "[git status --short]" | awk '{print $2}' | tr '\n' ' ' | gsed -re 's/ $//')
    echo $selected_files
    LBUFFER="${LBUFFER% } $selected_files"
    zle redisplay
}
zle -N peco-git-insert-modified-files-to-buffer
