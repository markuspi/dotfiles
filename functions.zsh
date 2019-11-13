#!/usr/bin/zsh

# prompts the user a yes/no question
# returns 0 (success) if user entered y or Y
function ask {
    echo -n "$1 [y/N] "
    read answer
    [ "$answer" != "${answer#[Yy]}" ]
    return
}

function venv {
    if [ -d "venv" ]; then
        . venv/bin/activate
    elif [ -d ".venv" ]; then
        . .venv/bin/activate
    else
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
    cmd="$(urlencode "$*")"
    url="https://explainshell.com/explain?cmd=$cmd"
    xdg-open "$url"
}
