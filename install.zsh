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

for file in "$HOME"/.dotfiles/home/*; do
    name="${file:t}"
    linkname="$HOME/.$name"

    # check if there is a non-link file that would be overwritten
    if [ -e "$linkname" ] && [ ! -L "$linkname" ]; then
        echo "Baking up: $linkname >> $linkname.bak"
        mv "$linkname" "$linkname.bak"
    fi

    if [ -L "$linkname" ]; then
        echo "Deleting old link $linkname"
        rm "$linkname"
    fi

    echo "Linking $linkname -> $file"
    ln -s "$file" "$linkname"
done

echo "Done. You may need to log in again to see the effect"
