function peco-z-search() {
    which peco z > /dev/null
    if [ $? -ne 0 ]; then
        echo "Please install peco and z"
        return 1
    fi
    local res=$(z | sort -rn | cut -c 12- | peco)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N peco-z-search

function _peco-git-log() {
    local hash=$(git log --oneline --branches | peco | awk '{print $1}')
    echo $hash
    return
}

function peco-git-rebase() {
    local hash=`_peco-git-log`
    if [ -n "${hash}" ]; then
        BUFFER="git rebase -i ${hash}"
        if zle; then
            zle accept-line
        else
            print -z "$BUFFER"
        fi
    fi
    if zle; then
        zle clear-screen
    fi
}
zle -N peco-git-rebase

