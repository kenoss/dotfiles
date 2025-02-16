# -*- coding: utf-8 -*-


# Comment out when profiling zshrc
# zmodload zsh/zprof && zprof


source "$ZDOTDIR"/config/antigen.zsh

load-zsh-config config/util.sh
load-zsh-config config/path.sh
load-zsh-config config/env.sh
load-zsh-config config/alias.sh
load-zsh-config config/function-utils.sh
load-zsh-config config/hook.sh
load-zsh-config config/command-utils.sh
load-zsh-config config/command-histgrep.sh
load-zsh-config config/command-peco.sh
load-zsh-config config/feature-kubectl.sh
load-zsh-config config/feature-peco-misc.zsh
load-zsh-config config/feature-pet.zsh
load-zsh-config config/misc.zsh
load-zsh-config config/powerline.sh
load-zsh-config config/bindings.zsh


if (which zprof > /dev/null 2>&1) ;then
    zprof
fi
