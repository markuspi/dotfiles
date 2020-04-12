#!/bin/sh
set -e

REPO_URL="https://github.com/markuspi/dotfiles"

ask() {
    echo -n "$1 [yN] "
    read answer
    [ "$answer" != "${answer#[Yy]}" ]
    return
}

if ask "Do you want to use sudo features for installation?"; then
    echo "Installing dependencies"
    sudo apt install -y git vim zsh fonts-powerline python3-dev python build-essential python3-pip tmux

    echo "Setting zsh as shell for current user"
    sudo chsh -s /bin/zsh "$USER"
else
    echo "You probably have to add 'zsh -l' to your startup file manually."
fi

if ! [ -x "$(command -v git)" ]; then
    echo "Error: git is not installed" >&2
    exit 1
fi

TMP_DIR="$(mktemp -d)"

if ! [ -x "$(command -v python3)" ]; then
    echo "Error: python3 is not installed" >&2
    exit 1
fi

if ! [ -x "$(command -v pip3)" ]; then
    echo "pip3 is not installed, installing locally..."
    wget -O "$TMP_DIR/get-pip.py" https://bootstrap.pypa.io/get-pip.py
    python3 "$TMP_DIR/get-pip.py" --user
fi

if ! [ -x "$(command -v zsh)" ]; then
    echo 'Error: zsh is not installed' >&2

    if ask "Do you want to install it from source?"; then
        wget -O "$TMP_DIR/zsh.tar.xz" "https://sourceforge.net/projects/zsh/files/zsh/5.7.1/zsh-5.7.1.tar.xz/download"
        echo "7260292c2c1d483b2d50febfa5055176bd512b32a8833b116177bf5f01e77ee8  $TMP_DIR/zsh.tar.xz" | sha256sum -c
        tar -xf "$TMP_DIR/zsh.tar.xz"
        cd "$TMP_DIR/zsh-5.7.1"
        ./configure --prefix="$HOME/.local/"
        make
        make install
    else
        exit 1
    fi
fi

echo "Installing antigen"
mkdir -p "$HOME/.local/bin"
wget -O "$HOME/.local/bin/antigen.zsh" https://git.io/antigen

if [ -d "$HOME/.dotfiles" ]; then
    echo "Updating dotfiles"
    git -C "$HOME/.dotfiles" pull
else
    echo "Retrieving dotfiles"
    git clone "$REPO_URL" "$HOME/.dotfiles"
fi

rm -rf "$TMP_DIR"

echo "Installing dotfiles"
"$HOME/.dotfiles/install.zsh"
