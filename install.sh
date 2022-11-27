#!/bin/sh

set -ex

bin/setup

# Homebrew does not allow sudo.
case "$(uname)" in
    "Darwin")
        USER_HOME="$HOME" bin/mitamae local $@ lib/recipe.rb
        ;;
    *)
        USER_HOME="$HOME" sudo -E bin/mitamae local $@ lib/recipe.rb
        ;;
esac
