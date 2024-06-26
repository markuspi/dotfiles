#!/usr/bin/env zsh
set -e

if [[ "$HOME" != "/home"* ]]; then
    echo "Your home directory is unusual: $HOME"
    vared -p "Do you want to continue? [yN] " -c ans

    case $ans in
       [yY] ) ;;
       * ) exit;;
    esac
fi

function make_links {
    for file in "$1"/*(D); do
        name="${file:t}"
        linkname="$2/$name"

        # check if there is a non-link file that would be overwritten
        if [ -e "$linkname" ] && [ ! -L "$linkname" ]; then
            echo "Backing up: $linkname >> $linkname.bak"
            mv "$linkname" "$linkname.bak"
        fi

        if [ -L "$linkname" ]; then
            echo "Deleting old link $linkname"
            rm "$linkname"
        fi

        echo "Linking $linkname -> $file"
        ln -s "$file" "$linkname"
    done
}

make_links "$HOME/.dotfiles/home" "$HOME"
make_links "$HOME/.dotfiles/bin" "$HOME/.local/bin"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Temparily adding .local/bin to PATH"
# force path array to be have unique items
typeset -U path
path+="$HOME/.local/bin"

# install useful python packages
pipx install tldr poetry
git config --global core.excludesfile ~/.gitignore-system

echo "Done. You may need to log in again to see the effect"
