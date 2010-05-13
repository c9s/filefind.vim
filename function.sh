
# Quick find# {{{

function f() {
    echo "find . -type f -iname \"*$1*\""
    find . -type f -iname "*$1*"
}

function fv() {
    echo "find . -type f -iname \"*$1*\"\n""`find . -iname "*$1*"`" | vim -
}

