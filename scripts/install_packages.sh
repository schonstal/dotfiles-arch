#!/usr/bin/env bash

echo "Ensuring packages are up to date..."
pacman -Syy

install_package() {
    echo ""
	echo -e "📦 \033[1;33mInstalling Package: \033[1;34m$1\033[0m"
    echo -e "\033[1;30m◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢\033[0m"

	sudo pacman -S $1
}

packages=(
	nvim
	ghostty
	tmux
	fish
)

for app in ${packages[@]}; do
	install_package $app
done

echo "Finished installing packages!"

