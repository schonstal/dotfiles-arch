#!/usr/bin/env bash

if [ $EUID = 0 ]; then
    echo "Do not run the script as root. Run it as the user that wants the dotfiles."
fi

packages=(
    nvim
    ghostty
    tmux
    fish
    yazi
)

dots_only=(
    zmk
)

install_only=(
    git
    stow
)

color_echo() {
    echo -e "\033[1;$1m$2\033[0m"
}

while getopts i flag
do
    case "${flag}" in
        i) install_packages=true;;
    esac
done

if [ "$install_packages" = true ]; then
    color_echo 33 "Ensuring packages are up to date..."
    color_echo 30 "==================================="
    sudo pacman -Syy

    to_install+=( "${packages[@]}" "${install_only[@]}" )

    echo ""
    color_echo 33 "Installing packages..."
    color_echo 30 "==================================="
    for package in ${to_install[@]}; do
        echo ""
        echo -e "\033[1;33mInstalling Package: \033[1;34m$package\033[0m"
        sudo pacman -S $package
    done

    echo ""
    echo "Finished installing packages!"
else
    echo -e "\033[1;33mwarning:\033[0m Skipping package install. If you wish to install packages, use -i"
fi

echo ""
color_echo 33 "Updating git submodules..."
color_echo 30 "==================================="

git submodule update --init --progress --remote --recursive

echo ""
color_echo 33 "Creating dotfile symlinks..."
color_echo 30 "==================================="

to_stow+=( "${dots_only[@]}" "${packages[@]}" )

for package in ${to_stow[@]}; do
    echo ""
    if [ -d "$package" ]; then
        echo -e "\033[1;33mLinking dotfiles for: \033[1;34m$package\033[0m"
        stow --verbose=2 --adopt --target=$HOME $package
    else
        echo -e "\033[1;31mDotfiles not found for: \033[1;34m$package\033[0m"
    fi
done

echo ""
color_echo 32 "Dotfile setup complete!"
