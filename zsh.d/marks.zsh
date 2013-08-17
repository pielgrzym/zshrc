export MARKPATH=$HOME/.marks

mark_go() {
        cd -P ${PROJECTS_ROOT:=$HOME/work}/$1/git 2>/dev/null || cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark $1"
}
alias c=mark_go

mark() { 
        mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
alias m=mark

unmark() { 
        rm -i $MARKPATH/$1 
}

marks() {
        for link in $MARKPATH/*(@); do
                echo "$fg[cyan] ${link:t} $reset_color -> $fg[blue] $(readlink $link) $reset_color"
        done
}
alias ms=marks

_mark_go_cpl() {
        reply=($MARKPATH/*(@:t))
        reply+=(${PROJECTS_ROOT:=$HOME/work}/*(/:t))
}
compctl -K _mark_go_cpl mark_go
