if (( ${+commands[keychain]} )); then
    if [[ -d $HOME/.ssh ]]; then
        if [[ -f $HOME/.ssh/id_dsa ]]; then
            eval `keychain --eval --nogui -Q -q ~/.ssh/id_dsa`
        elif [[ -f $HOME/.ssh/id_rsa ]]; then
            eval `keychain --eval --nogui -Q -q ~/.ssh/id_rsa`
        fi
    fi
fi
