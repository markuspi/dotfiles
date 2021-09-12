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
    sudo apt update
    sudo apt install -y git vim zsh fonts-powerline python3-dev python build-essential pkg-config cmake curl python3-pip tmux htop powerline

    echo "Setting zsh as shell for current user"
    sudo chsh -s /bin/zsh "$USER"
else
    NON_SUDO=1
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
        ZSH_LOCATION="$HOME/.local/bin/zsh"
    else
        exit 1
    fi
else
    ZSH_LOCATION="$(which zsh)"
fi

if [[ -v NON_SUDO ]]; then
    if [[ "$SHELL" == *bash ]]; then
        echo "looks like you are using bash"

        if ask "Do you want me to edit .bashrc to automatically start zsh?"; then
            touch "$HOME/.bashrc"
            cp "$HOME/.bashrc" "$TMP_DIR/.bashrc"

            echo "writing to .bashrc"
            echo "MY_ZSH=\"${ZSH_LOCATION}\"" > "$HOME/.bashrc"
cat << 'EOF' >> "$HOME/.bashrc"
if [ -z "${NOZSH}" ] && [ $TERM = "xterm" -o $TERM = "xterm-256color" -o $TERM = "screen" ] && type "$MY_ZSH" &> /dev/null
then
    export SHELL="$MY_ZSH"
    if [[ -o login ]]
    then
        exec "$SHELL" -l
    else
        exec "$SHELL"
    fi
    return
fi

EOF
            cat "$TMP_DIR/.bashrc" >> "$HOME/.bashrc"
        else
            echo "you probably have to add 'exec zsh -l' to your startup file manually"
        fi
    elif [[ "$SHELL" == *zsh ]]; then
        echo "you are already using zsh"
    else
        echo "could not identify your current shell"
        echo "you probably have to add 'exec zsh -l' to your startup file manually"
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

echo "Installing duplicacy"
wget -O "$HOME/.local/bin/duplicacy" https://github.com/gilbertchen/duplicacy/releases/download/v2.7.2/duplicacy_linux_x64_2.7.2
chmod +x "$HOME/.local/bin/duplicacy"
echo "b83c2c8095839f00b7851967615e81ca4fbd4d255b4bfde9da9ba74ff85a852d $HOME/.local/bin/duplicacy" | sha256sum -c

rm -rf "$TMP_DIR"

echo "Installing dotfiles"
"$HOME/.dotfiles/install.zsh"
