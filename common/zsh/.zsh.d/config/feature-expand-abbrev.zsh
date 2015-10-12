# -*- mode: shell-script -*-

###
### Expand abbrev
###

function expand-abbrev() {
    if [ -z "$RBUFFER" ] ; then
        expand-abbrev-aux
    else
        zle end-of-line
    fi
}

function expand-abbrev-aux() {
    local init last value addleft addright
    typeset -A myabbrev
    myabbrev=(
        "DN"  "&> /dev/null"
        "L"   "| $PAGER "
        "G"   "| grep "
        "S"   "| sed '_|_'"
        "R"   " rm "
        "M"   " mkdir "
        "C"   " cat "
        "TX"  " tar -xvzf "
        "TC"  " tar -cvzf "
        "RS"  "rsync -av --exclude '\#*' --exclude '*~' "
        "FX"  "find _|_ -print0 | xargs -0 "
        "PWD" ""
    )

    init=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
    last=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
    value=${myabbrev[$last]}
    if [[ $value = *_\|_* ]] ; then
        addleft=${value%%_\|_*}
        addright=${value#*_\|_}
    else
        addleft=$value
        addright=""
    fi
    if [ "$last" = "PWD" ] ; then
        LBUFFER=""
        RBUFFER="$PWD"
    else
        LBUFFER=$init${addleft:-$last }
        RBUFFER=$addright$RBUFFER
    fi
}

zle -N expand-abbrev
