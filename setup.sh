if [ $EUID = 0 ]; then
    echo "Do not run the script as root. Run it as the user that wants the dotfiles."
fi

while getopts i flag
do
    case "${flag}" in
        i) install_packages=true;;
    esac
done

if [ "$install_packages" = true ]; then
	scripts/install_packages.sh
else
    echo -e "\033[1;33mwarning:\033[0m Skipping package install. If you wish to install packages, use -i"
fi

color_echo() {
    echo -e "\033[1;$1m$2\033[0m"
}

echo ""
color_echo 33 "Updating git submodules..."

git submodule init
git submodule update --progress

echo ""
color_echo 33 "Creating dotfile symlinks..."

stow --verbose --adopt --target=$HOME .

echo ""
color_echo 32 "Dotfile setup complete!"
