#!/bin/sh

set -e


version='280.0.0'
sha256_linux='11950f1db216ec7dc3abaf80722fb80518c38e279bd76b6924326fe660c209cf'
sha256_darwin='c9554507bc217a503b42bef7dfa72179bae57ad7e4e696af4205c50b373d3576'
target_dir="$HOME/.local/bin"
tar_path="$target_dir/google-cloud-sdk.tar.gz"

if [ -d "$target_dir/google-cloud-sdk" ]; then
    echo 'google-cloud-sdk is already installed'
    exit 0
fi

case "$(uname)" in
    'Linux')
        sha256_target="$sha256_linux"
        os_arch='linux-x86_64'
        ;;
    'Darwin')
        sha256_target="$sha256_darwin"
        os_arch='darwin-x86_64'
        ;;
    *)
        echo "unexpected uname: $(uname)"
        exit 1
        ;;
esac

curl -o "$tar_path" -fL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${version}-${os_arch}.tar.gz"
sha256="$(/usr/bin/openssl dgst -sha256 "$tar_path" | cut -d" " -f2)"
if [ "$sha256" != "$sha256_target" ]; then
    echo "checksum verification failed!\nexpected: ${sha256_target}\n  actual: ${sha256}"
    exit 1
fi

cd "$target_dir"
tar xvzf "$tar_path"
rm "$tar_path"

bash "$target_dir/google-cloud-sdk/install.sh"
