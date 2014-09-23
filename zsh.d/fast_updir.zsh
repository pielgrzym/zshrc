# borrowed from Mikachu (#zsh at freenode): http://mika.l3ib.org/code/dot-zshrc
# just type '...' to get '../..'
rationalise-dot() {
        local MATCH
        if [[ $LBUFFER == (|*['/ '$'\t\n''|;&']).. ]]; then
                LBUFFER+=/
                zle self-insert
                zle self-insert
        else
                zle self-insert
        fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
[[ -n ${(M)keymaps:#isearch} ]] && bindkey -M isearch . self-insert
