
# package related
alias up="sudo apt update && sudo apt upgrade -y"
alias inst="sudo apt install"
alias alig="apt list --installed 2>/dev/null | grep"
alias sinst="sudo snap install"
alias aptr="sudo apt autoremove -y"
alias pinst="pip3 install"

alias p2="python2"
alias p3="python3"
alias bp="python -m bpython"
alias hist="history | grep"
alias myip="hostname -I"
alias tmpd='cd $(mktemp -d /tmp/mytmp.XXX)'
alias x="xdg-open"
alias apk-search="adb shell pm list packages | grep"
alias www="myip && python3 -m http.server"
alias www!="(sleep 2 && x 'http://localhost:8000/') & www"
alias sysc="sudo systemctl"
alias epoch="date +%s"
alias sav='git commit -m "Autosave ($(date +"%F %T"))" && git push'
alias mine='sudo chown -R "$(id -u):$(id -g)"'
alias procwait='tail -f /dev/null --pid'
alias nb='jupyter notebook'
alias ntst="sudo netstat -tulpen"
alias pw="cat /dev/urandom | tr -dc A-Za-z0-9 | head -c"
alias pw2="cat /dev/urandom | tr -dc 'A-Za-z0-9!$&/()=?;:,._' | head -c"

# python single line scripts
alias hex="python3 -c 'import sys; print(hex(int(sys.argv[1])))'"
alias div="python3 -c 'import sys; x,y = int(sys.argv[1]),int(sys.argv[2]); print(x // y, x % y)'"
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'
alias bits='python3 -c "import sys; print([i for i, x in enumerate(bin(int(sys.argv[1]))[::-1]) if x == \"1\"])"'

# edit common config files
alias ed-al="vim ~/.dotfiles/scripts/aliases.zsh && . ~/.dotfiles/scripts/aliases.zsh"
alias ed-fun="vim ~/.dotfiles/scripts/functions.zsh && . ~/.dotfiles/scripts/functions.zsh"
alias ed-vim="vim ~/.vimrc"
alias ed-ssh="vim ~/.ssh/config"
alias ed-zsh="vim ~/.zshrc"
alias ed-tx="vim ~/.tmux.conf"

alias dot-pull="git -C ~/.dotfiles pull && ~/.dotfiles/install.zsh"

# vi: ft=zsh
