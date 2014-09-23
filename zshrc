# colors {{{1
autoload colors
colors
. $ZDOTDIR/zsh.d/nice_colors.zsh
# path {{{1
PATH=$ZDOTDIR/bin:$PATH
# completion {{{1
. $ZDOTDIR/zsh.d/completions.zsh
# functions {{{1
# remote confirm wrapper {{{2
function rconfirm(){
        if (( ${+SSH_CONNECTION} ));then
                local confirm
                echo " ___ "
                echo "{o,o}"
                echo "|)__)"
                echo "-\"-\"-"
                echo "O RLY?"
                read -q confirm
                if [[ $confirm == "y" || $confirm == "t" ]]; then
                        echo "\n"
                        "$@"
                else
                        echo "\n"
                        echo " ___ "
                        echo "{o,o}"
                        echo "(__(|"
                        echo "-\"-\"-"
                        echo "NO WAI!"
                fi
        else
                "$@"
        fi
}
# extract {{{2
. $ZDOTDIR/zsh.d/extract.zsh
# smart sudo {{{2
. $ZDOTDIR/zsh.d/smart_sudo.zsh
# aliases {{{1
. $ZDOTDIR/zsh.d/aliases.zsh
# directories {{{1
. $ZDOTDIR/zsh.d/dirstack.zsh
# grep {{{1
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
bindkey -v
# history {{{1
# options {{{2
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTIGNORE="[   ]*:&:bg:fg:clear:hr:hc"

setopt hist_ignore_dups # ignore duplication command history list
unsetopt share_history # by some queer accident it was turned on (horror!)

setopt hist_verify
#setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space

setopt APPEND_HISTORY

# branching functions {{{2
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

# branching aliases {{{2
alias hr=checkout_master_history_branch
alias hc=create_history_branch
# keybindings {{{1
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^F' history-incremental-search-forward

#stty intr '^x'

bindkey "^Xh" _complete_help
bindkey "^X?" _complete_debug
bindkey "^Xx" execute-named-cmd
## file rename magick
bindkey "^X^m" copy-prev-shell-word
bindkey "^Xm" _most_recent_file
bindkey "^X^X" vi-beginning-of-line
bindkey "^X^A" vi-end-of-line

# virtualenvwrapper {{{1
prepare_wrapper() {
        export WORKON_HOME=$HOME/.virtualenvs
        if [[ -f /usr/bin/virtualenvwrapper.sh ]]; then
                source /usr/bin/virtualenvwrapper.sh
        else
                source /etc/bash_completion.d/virtualenvwrapper
        fi
}
alias vew=prepare_wrapper
prepare_rvm() {
        if [[ -x $HOME/.rvm/scripts/rvm ]]; then
                source $HOME/.rvm/scripts/rvm 
                export RPROMPT=$( $HOME/.rvm/bin/rvm-prompt )
        fi
}
alias rew=prepare_rvm
# misc {{{1
## smart urls
export EDITOR=vim
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
## jobs
setopt long_list_jobs
# Make things split words by shell arguments, not spaces
autoload -U select-word-style
select-word-style s
setopt no_beep
# got to observe if theese actually make any performance difference:
#setopt multios
#setopt cdablevarS
## pager
export PAGER=less
# fix ipython pager
export LESS=-r
# complete with sudo {{{1
insert_sudo () { zle beginning-of-line; zle -U "s " }
zle -N insert-sudo insert_sudo
bindkey "^Xs" insert-sudo
bindkey '^i' complete-word # this is *VERY* important read below:
# fast ../.. directory ascension {{{1
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
# gpg pinentry {{{1
# I HATE YOU pinentry-curses
export GPG_TTY=$(tty)
# keychain {{{1
if (( ${+commands[keychain]} )); then
        if [[ -f $HOME/.ssh/id_dsa ]]; then
                eval `keychain --eval --nogui -Q -q ~/.ssh/id_dsa`
        elif [[ -f $HOME/.ssh/id_rsa ]]; then
                eval `keychain --eval --nogui -Q -q ~/.ssh/id_rsa`
        fi
fi
# prompt {{{1
. $ZDOTDIR/zsh.d/prompt.zsh
# givotal {{{1
if [[ -d $HOME/work/givotal ]]; then
        export PATH=~/work/givotal/git:$PATH
        source ~/work/givotal/git/completion/git-pivotal-completion.zsh
        alias gvf="git pv fetchall"
        alias gvc="git pv current"
        alias gvb="git pv backlog"
        alias gvm="git pv mywork"
        alias gvr="git pv review"
        alias gva="git pv accept"
        alias gvj="git pv reject"
        alias gvs="git pv start"
        alias gvv="git pv show"
        alias gvfn="git pv finish"
        alias gvd="git pv deliver"
fi
# edit-command-line {{{1
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
# project starter {{{1
if [[ -n $PIEL_PROJ && -n $PIEL_PROJ_DIR ]]; then
        cd $PIEL_PROJ_DIR
        if [[ -d $HOME/.virtualenvs/$PIEL_PROJ ]]; then
                export WORKON_HOME=$HOME/.virtualenvs
                source /usr/bin/virtualenvwrapper.sh
                workon $PIEL_PROJ
        fi
fi
# zsh-history-substring-search {{{1
if [[ -d $ZDOTDIR/zsh-history-substring-search ]]; then
        source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^P' history-substring-search-up
        bindkey '^N' history-substring-search-down
fi
# todotxt date expansion {{{1
date-expansion() {
        # a helper for todotxt
        # if you type #<stuff> and hit space the substitution occurs:
        # todo.sh add stuff #j => todo.sh add stuff 2012-11-04
        # #j - tommorow
        # #t - next week
        # #23 - 23rd day of current/next month
        # #23.11 - 23.11 of current/next year
        # #pn - next monday
        # #..
        # #nd - next sunday
        # if we want not to insert expansion but literal text just press Ctrl-x before hitting space
        setopt extendedglob
        local MATCH
        LBUFFER=${LBUFFER%%(#m)\#[.bcjpwtsrzondt0-9]##}
        if [[ -n $MATCH ]]; then
                case "$MATCH" in
                        \#j)
                                res=$(date --date="next day" +"%Y-%m-%d")
                                ;;
                        \#t)
                                res=$(date --date="next week" +"%Y-%m-%d")
                                ;;
                        \#p[n]#) # either #p or #pn
                                res=$(date --date="next Monday" +"%Y-%m-%d")
                                ;;
                        \#w[t]#) # either #w or #wt
                                res=$(date --date="next Tuesday" +"%Y-%m-%d")
                                ;;
                        \#sr)
                                res=$(date --date="next Wednesday" +"%Y-%m-%d")
                                ;;
                        \#c[zw]#) # either #c #cz or #czw
                                res=$(date --date="next Thursday" +"%Y-%m-%d")
                                ;;
                        \#pt)
                                res=$(date --date="next Friday" +"%Y-%m-%d")
                                ;;
                        \#s[ob]#) # #s #so #sob
                                res=$(date --date="next Saturday" +"%Y-%m-%d")
                                ;;
                        \#n[d]#) # #n #nd
                                res=$(date --date="next Sunday" +"%Y-%m-%d")
                                ;;
                        (#m)\#[0-9]##) # #23, #<digits>
                                cur_day=$(date +"%d")
                                day=${MATCH##\#}
                                if [[ $day -lt $cur_day ]]; then
                                        res="$(date --date="next month" +"%Y-%m-")${day}"
                                else
                                        res="$(date +"%Y-%m-")${day}"
                                fi
                                ;;
                        \#[0-9]##\.[0-9]##) # 23.11, #<digits>.<digits>
                                local month day
                                day=${${MATCH%%.*}##\#}
                                month=${MATCH#*.}
                                cur_month=$(date +"%m")
                                cur_day=$(date +"%d")
                                if [[ "$month" -lt "$cur_month" ]]; then
                                        res="$(date --date="next year" +"%Y")-$month-$day"
                                elif [[ "$day" -lt "$cur_day" && "$month" -eq "$cur_month" ]]; then
                                        res="$(date --date="next year" +"%Y")-$month-$day"
                                else
                                        res="$(date +"%Y")-$month-${day##\#}"
                                fi
                                ;;
                        *)
                                res=" "
                                ;;
                esac
                LBUFFER+=$res
        fi
        zle self-insert
        unsetopt extendedglob
}
no-date-expansion() {
        LBUFFER+=' '
}
zle -N date-expansion
zle -N no-date-expansion
bindkey " " date-expansion
bindkey "^x " no-date-expansion
bindkey -M isearch " " self-insert
# todotxt {{{1
export PATH=$ZDOTDIR/todotxt:$PATH
smart_todotxt() {
        if [[ -n $1 ]]; then
                todo.sh $argv
        else
                # I set default project name with autoenv .env files like this:
                # export TODO_PROJ="+someProjName @somecontext"
                # and I don't have to reapeat it this way
                if [[ -n $TODO_PROJ ]]; then
                        todo.sh ls $TODO_PROJ
                else 
                        todo.sh ls @komp
                fi
        fi
}

watch_todo(){
        tput smcup
        while : ; do
                tput clear
                echo -n "${bg[cyan]}[[[ TODO: ]]]$reset_color\n"
                if [[ -n $1 ]]; then
                        todo.sh "$@"
                else
                        todo.sh ls
                fi
                trap 'break' 2
                inotifywait -e close_nowrite -e close_write $HOME/Dropbox/t/todo.txt -qq
        done
        tput rmcup
}

watch_inbox(){
        tput smcup
        while : ; do
                tput clear
                echo -n "${bg[green]}${fg[black]}[[[ INBOX: ]]]$reset_color\n"
                todo.sh lf inbox.txt
                trap 'break' 2
                inotifywait -e close_nowrite -e close_write $HOME/Dropbox/t/inbox.txt -qq
        done
        tput rmcup
}

compdef smart_todotxt=todo.sh
alias t='noglob smart_todotxt'
alias tl='t ls'
alias ta='t add'
alias tm='t addto maybe.txt'
alias tlm='t lf maybe.txt'
alias td='t do'
alias tp='t pri' # t p <num> <prio>
alias i="t addto inbox.txt"
alias il="t lf inbox.txt"
alias wt=watch_todo
alias wi=watch_inbox
move_from_inbox(){
        t mv $1 todo.txt inbox.txt 
}
alias im=move_from_inbox
# autoenv {{{1
if [[ -f $ZDOTDIR/autoenv/activate.sh ]]; then
        source $ZDOTDIR/autoenv/activate.sh
fi
# z (the new j, yo!) {{{1
if [[ -f $ZDOTDIR/z/z.sh ]]; then
        _Z_CMD='j'
        . $ZDOTDIR/z/z.sh
fi
# marks {{{1
. $ZDOTDIR/zsh.d/marks.zsh
# teamocil {{{1
export TEAMOCIL_PATH=$ZDOTDIR/teamocil
# completions for proj {{{2
_proj_cpl() {
        reply=($HOME/work/*(/:t))
        reply+=("zsh" "vim" "tmux")
}
compctl -K _proj_cpl proj
# modeline {{{1
# vim: fdm=marker:fdl=0
