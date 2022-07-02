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

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=8'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=8'

if [ -x "$(command -v thefuck)" ]; then
    eval $(thefuck --alias)
fi

if [ -f ~/.dotfiles/zshrc.local ]; then
    source ~/.dotfiles/zshrc.local
fi

# kdesrc-build #################################################################

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"


## Autocomplete for kdesrc-run
function _comp_kdesrc_run
{
  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Complete only the first argument
  if [[ $COMP_CWORD != 1 ]]; then
    return 0
  fi

  # Retrieve build modules through kdesrc-run
  # If the exit status indicates failure, set the wordlist empty to avoid
  # unrelated messages.
  local modules
  if ! modules=$(kdesrc-run --list-installed);
  then
      modules=""
  fi

  # Return completions that match the current word
  COMPREPLY=( $(compgen -W "${modules}" -- "$cur") )

  return 0
}

## Register autocomplete function
complete -o nospace -F _comp_kdesrc_run kdesrc-run

################################################################################

