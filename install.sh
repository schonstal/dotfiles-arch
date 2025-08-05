#!/usr/bin/env bash

echo "Initializing submodules"

git submodule init
git submodule update

echo "Stowing config files"

stow --verbose --adopt --target=$HOME .

echo "Finished!"

