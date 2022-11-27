#! /usr/bin/env bash

echo -n 'Simple description of machine: '
read name

set -x

ssh-keygen -t ed25519 -C "keno.ss57@gmail.com ($name)"
