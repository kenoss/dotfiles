# -*- coding: utf-8 -*-

source $ZDOTDIR/256colorlib.zsh
# [ -f $ZDOTDIR/.zshrc.$(uname) ] && source $ZDOTDIR/.zshrc.$(uname)


function upload-ical () {
    local DIR=~/org/calendars
    emacs -batch -l ~/.emacs.d/init.d/50-org-mode.el -eval '(my-org-export-icalendar)'
    for file in workshop seminor
    do
        local code=$(nkf -g $DIR/$file.ics)
        if [ $code = "UTF-8" ] ; then
            mv $DIR/$file.ics $DIR/out/
        elif [ $code = "EUCJP-MS" ] ; then
            iconv -f EUC-JP -t UTF-8 $DIR/$file.ics > $DIR/out/$file.ics
            rm $DIR/$file.ics
        else
            iconv -f $code -t UTF-8 $DIR/$file.ics > $DIR/out/$file.ics
            rm $DIR/$file.ics
        fi
        cp -ap $DIR/$file.org $DIR/out/
    done
    chmod 644 $DIR/out/*
    scp $DIR/out/* $DIR/out/.* keno@irissanguinea.no-ip.org:/usr/home/www/ics/
}



function refrect-vbox-win () {
    local VBOXHOME=~/VirtualBox/sharedirs/WHSallread/home
    rsync -avL ~/.vimperator $VBOXHOME/
    mv $VBOXHOME/{.,}vimperator
    cp -a ~/.vimperatorrc ~/VirtualBox/sharedirs/WHSallread/home/vimperator/
}

UPLATEX=/usr/local/texlive/2012/bin/amd64-freebsd/uplatex
EPLATEX=/usr/local/texlive/2012/bin/amd64-freebsd/platex
DVIPDFMX=/usr/local/texlive/2012/bin/amd64-freebsd/dvipdfmx
function uplatex-pdf(){
    local filesans="${1%.*}"
    $UPLATEX "$filesans.tex" && $UPLATEX "$filesans.tex" && $DVIPDFMX "$filesans"
}
function uplatex-pdf-view(){
    local filesans="${1%.*}"
    uplatex-pdf "$filesans" && evince "$filesans.pdf"
}
function eplatex-pdf(){
    local filesans="${1%.*}"
    $EPLATEX "$filesans.tex" && $EPLATEX "$filesans.tex" && $DVIPDFMX "$filesans"
}
function eplatex-pdf-view(){
    local filesans="${1%.*}"
    eplatex-pdf "$filesans" && evince "$filesans.pdf"
}
