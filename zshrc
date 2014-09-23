# colors {{{1
autoload colors
colors
. $ZDOTDIR/zsh.d/nice_colors.zsh
# path {{{1
PATH=$ZDOTDIR/bin:$PATH
# completion {{{1
. $ZDOTDIR/zsh.d/completions.zsh
# rly? {{{1
. $ZDOTDIR/zsh.d/rly.zsh
# extract {{{1
. $ZDOTDIR/zsh.d/extract.zsh
# smart sudo {{{1
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
. $ZDOTDIR/zsh.d/history.zsh
. $ZDOTDIR/zsh.d/history_branching.zsh
# misc settings {{{1
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
# insert sudo widget {{{1
insert_sudo () { zle beginning-of-line; zle -U "s " }
zle -N insert-sudo insert_sudo
bindkey "^Xs" insert-sudo
bindkey '^i' complete-word # this is *VERY* important read below:
# fast directory ascension {{{1
. $ZDOTDIR/zsh.d/fast_updir.zsh
# gpg pinentry {{{1
# I HATE YOU pinentry-curses
# export GPG_TTY=$(tty)
# keychain {{{1
if (( ${+commands[keychain]} )); then
    if [[ -d $HOME/.ssh ]]; then
        if [[ -f $HOME/.ssh/id_dsa ]]; then
            eval `keychain --eval --nogui -Q -q ~/.ssh/id_dsa`
        elif [[ -f $HOME/.ssh/id_rsa ]]; then
            eval `keychain --eval --nogui -Q -q ~/.ssh/id_rsa`
        fi
    fi
fi
# prompt {{{1
. $ZDOTDIR/zsh.d/prompt.zsh
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
