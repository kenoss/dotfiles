function findgrep () {
    find $2 -type f -exec grep --with-filename $1 {} \;
}


# temporary definition
function exchange-mv () {
    mv $1 $1.exchangemv
    mv $2 $1
    mv $1.exchangemv $2
}


# FreeBSD only
function portsearch() {
    (cd /usr/ports/ > /dev/null ; make search name="$1" | less)
}


function install-firefox-pref() {
    local FIREFOXDIR=$HOME/.mozilla/firefox
    local RELSORCEDIR=prefscheme

    cd $FIREFOXDIR
    for destdir in $1; do
        {
            local file=prefs.js
            if [ -e $destdir/$file ]
            then
                mv -v $destdir/$file $destdir/$file.old.$(date "+%F-%H%M%S")
            fi
#            sed "/extensions.xmarks.clientName/ { s/$RELSORCEDIR/$destdir/; }" $RELSORCEDIR/prefs.js > $destdir/prefs.js
        }
        for file in extensions{,.ini,.sqlite} firegestures.sqlite # jetpack
        do
            if [ -e $destdir/$file ]
            then
                mv -v $destdir/$file $destdir/$file.old.$(date +%F)
            fi
            cp -pa -v $RELSORCEDIR/$file $destdir
        done
    done
}


function use-git-config () {
    local conf_path="$HOME/.gitconfig.$1"

    if [ ! -f "$conf_path" ]; then
        echo "Config file not found: $conf_path"
    else
        ln -sf "$conf_path" ~/.gitconfig
    fi
}
