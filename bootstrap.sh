#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/markuspi/dotfiles"

echo "Installing dependencies"
sudo apt install -y git vim curl zsh fonts-powerline python3-dev python

echo "Setting zsh as shell for current user"
sudo chsh -s /bin/zsh "$USER"

echo "Installing antigen"
mkdir -p "$HOME/.local/bin"
curl -L https://git.io/antigen -o "$HOME/.local/bin/antigen.zsh"

if [ -d "$HOME/.dotfiles" ]; then
    echo "Updating dotfiles"
    git -C "$HOME/.dotfiles" pull
else
    echo "Retrieving dotfiles"
    git clone "$REPO_URL" "$HOME/.dotfiles"
fi

echo "Installing dotfiles"
"$HOME/.dotfiles/install.zsh"
