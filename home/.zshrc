source ~/.local/bin/antigen.zsh
antigen init ~/.antigenrc

export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_DIR_TRUNC=5
export SPACESHIP_PROMPT_ORDER=(
    user
    dir
    host
    git
    venv
    pyenv
    ros
    exec_time
    line_sep
    battery
    jobs
    exit_code
    char
)
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES='_ git'

export PATH="$HOME/.local/bin:/snap/bin:$PATH"
export LANG=en_US.UTF-8

# colored manpages
export LESS_TERMCAP_mb=$'\C-[[1;32m'
export LESS_TERMCAP_md=$'\C-[[1;32m'
export LESS_TERMCAP_me=$'\C-[[0m'
export LESS_TERMCAP_se=$'\C-[[0m'
export LESS_TERMCAP_so=$'\C-[[01;33m'
export LESS_TERMCAP_ue=$'\C-[[0m'
export LESS_TERMCAP_us=$'\C-[[1;4;31m'

# source all files in scripts dir
for file in ~/.dotfiles/scripts/*.zsh; do
    source "$file"
done

if [ -x "$(command -v thefuck)" ]; then
    eval $(thefuck --alias)
fi

if [ -f ~/.dotfiles/zshrc.local ]; then
    source ~/.dotfiles/zshrc.local
fi
