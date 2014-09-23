# branching functions {{{1
# I like to keep a separate shell history for my projects (this makes it easier to
# reuse some older commands and predict is much more sensible in such scenario).
# As I would often forget to enable cusom history - I just set up zsh to do this 
# automatically if it finds a readable-writable-non-zero .zsh_custom_history file in PWD
# If I'm done I can simply type 'hr' to use global zsh history. If I have a fresh project
# I can simply type 'hc' and this will create and checkout new history branch.
# The checkout and branch terminology is borrowed from git - I use it everyday  :)
CUSTOM_HISTORY=0
create_history_branch() {
        if [[ -s .zsh_custom_history && -r .zsh_custom_history && -w .zsh_custom_history ]] 
        then # in case there already is a custom history for current dir
                checkout_history_branch
        else # otherwise let's create a new one!
                echo -n "${fg[blue]}History file '.zsh_custom_history' does not exist. Create a new one?$reset_color"
                read -q confirm
                if [[ $confirm == "y" || $confirm == "t" ]]; then
                        echo ""
                        echo "${fg[magenta]}Creating a new custom history branch$reset_color"
                        fc -p # pop current global history into stack and create new one
                        # below we need to tell zsh where to store the custom history and it's parameters
                        HISTFILE=$PWD/.zsh_custom_history
                        SAVEHIST=5000
                        HISTSIZE=5000
                        CUSTOM_HISTORY="H: $PWD"
                fi
        fi
}

checkout_history_branch() {
        echo "${fg[magenta]}Restoring custom history branch for current dir$reset_color"
        fc -p $PWD/.zsh_custom_history # put global hist on stack and use this one
        # below we need to tell zsh where to store the custom history and it's parameters
        HISTFILE=$PWD/.zsh_custom_history
        SAVEHIST=5000
        HISTSIZE=5000
        CUSTOM_HISTORY="H: $PWD"
}

checkout_master_history_branch() {
        echo "${fg[magenta]}Restoring master history branch$reset_color"
        fc -P # stash current history and pop global one from stack
        CUSTOM_HISTORY=0
}

# branching aliases {{{1
alias hr=checkout_master_history_branch
alias hc=create_history_branch
# modeline {{{1
# vim: fdm=marker:fdl=0
