# marks concept based on post by Jeroen Janssens:
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

export MARKPATH=$HOME/.marks

mark_go() {
        cd -P "${PROJECTS_ROOT:=$HOME/work}/$1/git" 2>/dev/null || cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark $1"
}
alias c=mark_go

echo_markpath() {
        if [[ -h "$MARKPATH/$1" ]]; then
                printf "$MARKPATH/$1"
        elif [[ -d "${PROJECTS_ROOT:=$HOME/work}/$1/git" ]]; then
                printf "${PROJECTS_ROOT:=$HOME/work}/$1/git"
        else
                printf $1
        fi
}


mark() { 
        if (( $# == 0 )); then
                marks
        else
                mkdir -p $MARKPATH; ln -s "$(pwd)" "$MARKPATH/$1"
        fi
}
alias m=mark

unmark() { 
        rm -i "$MARKPATH/$1" 
}

marks() {
        for link in $MARKPATH/*(@); do
                local markname="$fg[cyan]${link:t}$reset_color"
                local markpath="$fg[blue]$(readlink $link)$reset_color"
                printf "%s\t" $markname
                printf "-> %s \t\n" $markpath
        done
}

_mark_go_cpl() {
        reply=($MARKPATH/*(@:t))
        reply+=(${PROJECTS_ROOT:=$HOME/work}/*(/:t))
}

_unmark_cpl() {
        reply=($MARKPATH/*(@:t))
}

# use ctrl-g to replace inline mark name with full path:
# ls mymark<Ctrl-g>
# becomes:
# ls /Path/to/my/mark
_mark_expansion() {
        autoload -U modify-current-argument
        modify-current-argument '$(echo_markpath $ARG)'
}
zle -N _mark_expansion
bindkey "^g" _mark_expansion

compctl -K _mark_go_cpl mark_go
compctl -K _unmark_cpl unmark
