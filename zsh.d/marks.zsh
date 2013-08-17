export MARKPATH=$HOME/.marks

mark_go() {
        cd -P ${PROJECTS_ROOT:=$HOME/work}/$1/git 2>/dev/null || cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark $1"
}
alias g=mark_go

mark() { 
        mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
alias m=mark

unmark() { 
        rm -i $MARKPATH/$1 
}

marks() {
        for link in $MARKPATH/*; do
                echo "$fg[cyan] $(basename $link) $reset_color -> $fg[blue] $(readlink $link) $reset_color"
        done
}
alias ms=marks

_mark_go_cpl() {
        reply=($(cd $MARKPATH; print *(/)) $(cd ${PROJECTS_ROOT:=$HOME/work}; print *(/)) )
}
compctl -K _proj_cpl mark_go
