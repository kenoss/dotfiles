#!/bin/sh

set -e


version="196.0.0"
sha256_linux="4de5cc9b9e70cf08150cc7595a89a69efffee0f1e4c55dcb60c16601bfd5f0fc"
sha256_darwin="985ed75c67637041182425fe6669df66693de5ad89335d900903a7b8aa22bbe1"
tar_path="$HOME/bin/google-cloud-sdk.tar.gz"

if [ -d "$HOME/bin/google-cloud-sdk" ]; then
    echo 'google-cloud-sdk is already installed'
    exit 0
fi

case "$(uname)" in
    "Linux")
        sha256_target="$sha256_linux"
        os_arch='linux-x86_64'
        ;;
    "Darwin")
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

cd ~/bin
tar xvzf "$tar_path"
rm "$tar_path"

bash ~/bin/google-cloud-sdk/install.sh
