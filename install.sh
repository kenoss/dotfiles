#!/bin/sh

set -ex

if [ "$#" -ne 1 ]; then
    echo "$0 <role> <options...>"
    exit 1
fi

role="$1"
shift

bin/setup

# Homebrew does not allow sudo.
case "$(uname)" in
    "Darwin")
        bin/mitamae local $@ lib/node_supplement.rb lib/recipe_helper.rb "roles/$role/default.rb"
        ;;
    *)
        sudo -E bin/mitamae local $@ lib/node_supplement.rb lib/recipe_helper.rb "roles/$role/default.rb"
        ;;
esac
