
# package related
alias up="sudo apt update && sudo apt upgrade -y"
alias inst="sudo apt install"
alias upinst="sudo apt update && sudo apt install"
alias alig="apt list --installed | grep"
alias sinst="sudo snap install"

alias p3="python3"
alias hist="history | grep"
alias myip="hostname -I"
alias tmpd='cd $(mktemp -d /tmp/mytmp.XXX)'
alias x="xdg-open"
alias apk-search="adb shell pm list packages | grep"
alias www="myip && python3 -m http.server"
alias www!="(sleep 2 && x 'http://localhost:8000/') & www"
alias sysc="sudo systemctl"

# python single line scripts
alias hex="python3 -c 'import sys; print(hex(int(sys.argv[1])))'"
alias div="python3 -c 'import sys; x,y = int(sys.argv[1]),int(sys.argv[2]); print(x // y, x % y)'"
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'

# edit common config files
alias ed-al="vim ~/.dotfiles/aliases.zsh && . ~/.dotfiles/aliases.zsh"
alias ed-fun="vim ~/.dotfiles/functions.zsh && . ~/.dotfiles/functions.zsh"
alias ed-vim="vim ~/.vimrc"
alias ed-ssh="vim ~/.ssh/config"
alias ed-zsh="vim ~/.zshrc"

alias dot-pull="git -C ~/.dotfiles pull && ~/.dotfiles/install.zsh"

# vi: ft=zsh
