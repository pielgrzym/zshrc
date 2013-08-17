export MARKPATH=$HOME/.marks

mark_go() {
        cd -P ${PROJECTS_ROOT:=$HOME/work}/$1/git 2>/dev/null || cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark $1"
}
alias c=mark_go

mark() { 
        if (( $# == 0 )); then
                marks
        else
                mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
        fi
}
alias m=mark

unmark() { 
        rm -i $MARKPATH/$1 
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

compctl -K _mark_go_cpl mark_go
compctl -K _unmark_cpl unmark
