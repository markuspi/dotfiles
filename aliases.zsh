alias p3="python3"
alias hist="history | grep"
alias up="sudo apt update && sudo apt upgrade -y"
alias inst="sudo apt install"
alias sinst="sudo snap install"
alias alig="apt list --installed | grep"
alias myip="hostname -I"
alias hex="python3 -c 'import sys; print(hex(int(sys.argv[1])))' --"
alias tmpd="cd $(mktemp -d)"
alias x="xdg-open"
alias apk-search="adb shell pm list packages | grep"

# edit common config files
alias ed-al="vim ~/.dotfiles/aliases.zsh && . ~/.dotfiles/aliases.zsh"
alias ed-vim="vim ~/.vimrc"
alias ed-ssh="vim ~/.ssh/config"
alias ed-zsh="vim ~/.zshrc"

alias dot-pull="git -C ~/.dotfiles pull && ~/.dotfiles/install.zsh"

# vi: ft=zsh
