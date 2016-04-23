# -*- mode: shell-script -*-

###
### peco git
###

function git-repository-url {
    git remote -v | grep origin | grep fetch | gsed -r -e 's|^origin\t+ssh://git@(.*).git .*$|\1|' | (read host; echo https://$host)
}

function peco-git-merge-commit-url {
    local prid=$(git log --all --grep 'Merge pull request' --date=short --decorate=short \
                     --pretty=format:'%C(yellow)%h %C(reset)%cd %C(blue)%cn %C(red)%d %C(reset)%s' |
                        peco |
                        gsed -r -e 's/^.* #([0-9]+) .*$/\1/')
    local url=$(git-repository-url)
    echo "$url/pull/$prid"
}
