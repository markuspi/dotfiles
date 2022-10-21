#!/usr/bin/zsh

# prompts the user a yes/no question
# returns 0 (success) if user entered y or Y
function ask {
    echo -n "$1 [y/N] "
    read answer
    [ "$answer" != "${answer#[Yy]}" ]
    return
}

function vrun {
    dir="$(pwd)"
    for file in "$dir/venv/bin/python" "$dir/.venv/bin/python"; do
        if [ -f "$file" ]; then
            "$file" "$@"
            return
        fi
    done
    echo "No venv directory found!"
    return 1
}

function venv {
    dir="${1:-$(pwd)}"
    for file in "$dir/venv/bin/activate" "$dir/.venv/bin/activate" "$dir/bin/activate"; do
        if [ -f "$file" ]; then
            . "$file"
            return
        fi
    done

    if [ -f "Pipfile" ]; then
        pipenv shell
        return
    fi

    echo "No venv directory found! What do you want to do?"
    echo "0) abort"
    echo "1) create .venv directory"
    echo "2) create venv directory"
    echo -n "[0/1/2] "
    read answer
    if [[ "$answer" == "1" ]]; then
        virtualenv -p python3 .venv
        . .venv/bin/activate
    elif [[ "$answer" == "2" ]]; then
        virtualenv -p python3 venv
        . venv/bin/activate
    else
        return
    fi

    python -m pip install --upgrade pip

    if [ -f "requirements.txt" ]; then
        if ask "requirements.txt was found. Do you want to install the dependencies?"; then
            pip install -r requirements.txt
        fi
    fi
}

function mkcd {
    if [ "$#" -ne "1" ]; then
        echo "Usage: $0 <directory>"
        return -1
    fi

    mkdir -p "$1"
    cd "$1"
}

function apk-pull {
    if [ "$#" -ne "1" ]; then
        echo "Usage: $0 <search-term>"
        return -1
    fi

    search=$(apk-search "$1")
    results=$(echo $search | wc -l)
    if [ "$results" -ne "1" ]; then
        echo "Need exactly 1 result, got $results"
        return -1
    fi
    package="${search#*:}"
    packpath=$(adb shell pm path "$package")
    adb pull "${packpath#*:}"
}

function explain {
    xdg-open "https://explainshell.com/explain?cmd=$(urlencode "$*")"
}

function github {
    cd ~/Downloads/github
    git clone $1
}

function bak {
    mv "$1" "$1.bak"
}

function whichfile {
    file "$(which "$1")"
}

function b64enc {
    printf "$1" | base64
}

function b64dec {
    printf "$1" | base64 --decode
    printf "\n" 2>&1
}

function ggg {
    git commit -m "'$*'"
}

