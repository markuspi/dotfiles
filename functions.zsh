
function venv {
    if [ -d "venv" ]; then
        . venv/bin/activate
    else
        . .venv/bin/activate
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
