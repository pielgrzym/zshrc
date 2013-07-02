# colors {{{1
autoload colors
colors
if [[ `hostname` == 'abulafia' || `hostname` == 'black' ]]; then
        HOST_IS_LOCAL=1
else
        HOST_IS_LOCAL=0
fi

if [[ $HOST_IS_LOCAL == 1 ]]; then
        . $HOME/.zsh/nice_colors
fi
# named-directories {{{1
# theese are actually aliases for directories:
# ~ $ cd ~zsh
# ~/.zsh $
function mk_work_named_dirs() {
for p in `ls $HOME/work`
do
        hash -d $p="$HOME/work/$p"
done
}

if [[ -d ~/work ]]; then
mk_work_named_dirs
hash -d dn="$HOME/download"
hash -d zsh="$HOME/.zsh"
hash -d xmonad="$HOME/.xmonad"
hash -d vim="$HOME/.vim"
fi

hash -d logs="/var/log"
# completion {{{1
# options {{{2
unsetopt menu_complete   # do not autoselect the first completion entry
setopt flowcontrol # having C-s availible help a lot in completion->search mode
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word # perform completion from inside the word. Dude.
setopt always_to_end # everything dies...
WORDCHARS=''
# pip plugin 
fpath=($HOME/.zsh/completions/src $fpath)
autoload -U compinit
compinit 
zmodload -i zsh/complist

# zstyle magic - HERE BE DRAGONS {{{2
zstyle ':completion:*' accept-exact '*(N)'
# binding complete-word to TAB instead of expand-or-complete (the default). This 
# changes expansion behavior a lot. If you type ls *.avi<tab> (supposing there are
# avi files to list) it will give you a menu with all avi files.
zstyle ":completion:*:expand:*" group-order all-expansions expansions original 
# Above line will work when expanding string - first it shows a string with all expanded
# files - thing that usually is inserted by expand-or-complete. Later a menu of expansions
# and in the very end original expansion string ( like *.avi)
# Below: pretty color for each above-listed group:
zstyle ":completion:*:expand:*:*:all-expansions" format "%{$fg[green]%}%d %o%{$reset_color%}"
zstyle ":completion:*:expand:*:*:expansions" format "%{$fg[blue]%}%d %o%{$reset_color%}"
zstyle ":completion:*:expand:*:*:original" format "%{$fg[red]%}%d %o%{$reset_color%}"
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*:complete:*' use-cache 1
zstyle ':completion:*:complete:*' cache-path ~/.zsh/cache/
zstyle '*' single-ignored menu
# approximation of mistyped completes {{{3
zstyle ':completion:*' completer _oldlist _expand _complete _correct # with *.avi<tab> expand
#zstyle ':completion:*' completer _oldlist _complete _correct # without *.avi<tab> expand
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:corrections' format '%B---- %d %{$fg[red]%}(errors: %e)%{$reset_color%}%b'
# colorfull completions & grouping {{{3
# evil -> zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorfull completions
zstyle ':completion:*:*:*:argument-rest:*' list-colors ${(s.:.)LS_COLORS} # colorfull completions fast
zstyle ':completion:*:*:*:*:(all-expansions|all-files|files|paths|directories|directory-stack)' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*:*' list-colors ${(s.:.)LS_COLORS} # cd needs to be nice too
zstyle ':completion:*' group-name '' # separate completions into groups
zstyle ':completion:*' menu select # by default a select-menu for completions

# completion descriptions {{{3
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes' # this one and above will make options have nice docs!
zstyle ':completion:*:options' list-colors "=(#b) #(-[a-zA-Z0-9] #)*=38;5;32=$color[yellow]" # color single char opts
zstyle ':completion:*:options' menu true search # if there is a shitload of options it's more convenient than menu

# separators funn {{{3
zstyle ':completion:*:messages' format "%{$fg[red]%}%d %{$reset_color%}"
zstyle ':completion:*:warnings' format "%{$fg[red]%}Wrong: %d %{$reset_color%}"

# git {{{3
# we want nice git subcommand search inside descriptions
zstyle ':completion:*:complete:git:argument-rest:commands' menu true search
# non alias options colorfull :) whee :]
zstyle ':completion:*:complete:git:argument-rest:commands' list-colors "=(#b)([a-zA-Z0-9-]# )*=38;5;32=$color[yellow]"
# kill processes {{{3
# stopped working for some reason...
#zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#) #([0-9]#.[0-9]#) ([0-9a-z-]#) ([0-9a-z-]#) \
#        *=$color[green]=$color[red]=$color[yellow]=$color[cyan]=$color[blue]"
arr=( '' 8 88 2 64 32 )
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #${(l:9*9:: #([^ ]#):)}*${(j:=38;5;:)arr}"
zstyle ':completion:*:*:kill:*:processes' menu true
zstyle ':completion:*:*:*:*:processes' command "ps -A"

# ls / ls++ / cd stuff {{{3
# I like to have autocompletions for ls inserted immediately
zstyle ':completion:*:*:ls:*' menu true
zstyle ':completion:*:*:ls++:*' menu true
zstyle ':completion:*:*:cd:*' menu true # same for cd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack named-directories path-directories

# mplayer {{{3
zstyle ':completion:*:*:(napi|mplayer):*' menu true # insert autocompletions immediately
zstyle ':completion:*:*:(napi|mplayer):*' tag-order files # no urls in completions
# mplayer show only video files ; if no match then regular files; then dirs
zstyle ':completion:*:*:(napi|mplayer):*' file-patterns '*.(rmvb|mkv|mpg|wmv|mpeg|avi):video' '*:all-files' '*(-/):directories'

# extract (internal unpacking wrapper) {{{3
zstyle ':completion:*:*:extract:*' menu true
zstyle ':completion:*:*:extract:*' tag-order files # no urls in completions
zstyle ':completion:*:*:extract:*' file-patterns '*.(tar.bz2|tar.gz|tar.xz|tar.lzma|bz2|rar|gz|tar|tbz2|tgz|zip|Z|7z):all-files' '*(-/):directories'
# gvim/vim {{{3
zstyle ':completion:*:*:(gvim|vim):*:*files' ignored-patterns '*~' '*.pyc' '*.pyo' # ignore backups and pyc/pyo files
zstyle ':completion:*:*:(gvim|vim):*' file-sort access # sort by last used

# hosts, ssh, scp {{{3
# use /etc/hosts and known_hosts for hostname completion
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
hosts=( "$_ssh_hosts[@]" "$_etc_hosts[@]" `hostname` localhost)
zstyle ':completion:*:*:*:*:hosts' hosts $hosts
# above host completion is nice, but for ssh I want only hosts from .ssh/config - doesn't work :(
_cfg_ssh_hosts=(${${${(M)${(f)"$(<$HOME/.ssh/config)"}##Host *}#Host }#\*})
zstyle ':completion:*:*:ssh:*' menu false # rather no menu...
zstyle ':completion:*:*:ssh:*' tag-order hosts # only hosts in the suggestions
zstyle ':completion:*:*:(ssh|scp):*:hosts' hosts $_cfg_ssh_hosts  # only hosts from ~/.ssh/config
#zstyle ':completion:*:*:(su|sudo):*:users' user ${(k)userdirs}  # all users
zstyle ':completion:*:*:scp:*' menu true # here is your menu Sir
#zstyle ':completion:*:*:scp:*' group-order files hosts # I like to get hosts before files in scp
# prevent resugestions {{{3
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:scp:*' ignore-line yes
zstyle ':completion:*:ls:*' ignore-line yes
# corrections {{{1
# it's quite inconvenient to use with named-directories
unsetopt correct_all

#alias man='nocorrect man'
#alias mv='nocorrect mv'
#alias mysql='nocorrect mysql'
#alias mkdir='nocorrect mkdir'
#alias gist='nocorrect gist'
#alias heroku='nocorrect heroku'
#alias ebuild='nocorrect ebuild'
#alias hpodder='nocorrect hpodder'
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
function extract() {
  unset REMOVE_ARCHIVE
  
  if test "$1" = "-r"; then
      REMOVE_ARCHIVE=1
      shift
  fi
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz) tar xvzf $1;;
      *.tar.xz) tar xvJf $1;;
      *.tar.lzma) tar --lzma -xvf $1;;
      *.bz2) bunzip2 $1;;
      *.rar) nice -n 19 ionice -c 3 unrar x $1;;
      *.gz) gunzip $1;;
      *.tar) tar xvf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
      *.xz) unxz -d $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *.7z) 7z x $1;;
      *) echo "'$1' cannot be extracted via >extract<";;
    esac

    if [[ $REMOVE_ARCHIVE -eq 1 ]]; then
        echo removing "$1";
        /bin/rm "$1";
    fi

  else
    echo "'$1' is not a valid file"
  fi
}
# term title {{{2
term_title() {
printf \\033]0\;\%s\\007 "$1"
}
# irssi runner {{{2
# I never start irssi in plain term - always in tmux
# this convenience wrapper connects to tmux session if 
# availible or creates a new one with irssi :)
run_or_attach_irssi() {
        if tmux has-session -tirssi; then
                tmux at -tirssi
        else
                tmux new -sirssi irssi
        fi
}
# weechat runner {{{2
run_or_attach_weechat() {
        if tmux has-session -twee; then
                tmux at -twee
        else
                tmux new -swee weechat-curses
        fi
}

# sys session runner {{{2
run_or_attach_sys(){
        if tmux has-session -tsys; then
                tmux at -t sys
        else
                tmux new-session -d -ssys -n root 'sudo -s'
                tmux split-window -h -tsys:0 'cd /var/log/; tail -f everything.log | ccze -A' 
                tmux new-window -d -tsys:1 -n ranger 'ranger'
                tmux new-window -d -tsys:2 -n stuff
                tmux select-window -tsys:0
                tmux select-pane -L
                tmux at -tsys
        fi
}
# smart sudo {{{2
# Give us a root shell, or run the command with sudo.
# Expands command aliases first (cool!)

smart_sudo () {
    if [[ -n $1 ]]; then
        #test if the first parameter is a alias
        if [[ -n $aliases[$1] ]]; then
            #if so, substitute the real command
            sudo ${=aliases[$1]} $argv[2,-1]
        else
            #else just run sudo as is
            sudo $argv
        fi
    else
        #if no parameters were given, then assume we want a root shell
        sudo -s
    fi
}
# ctags for virtuaenv {{{2
make_ctags(){
        cur_dir=$(basename $(pwd))
        if [[ $VIRTUAL_ENV != "" && $cur_dir == "git" ]]; then
               ctags -R $VIRTUAL_ENV/lib/python?.?
               ctags -a *
        fi
}
# headphones/speakers {{{2
headphones() {
        amixer -c 0 -- sset Front unmute 
        amixer -c 0 -- sset Surround mute
        amixer -c 0 -- sset PCM 50%
}

speakers() {
        amixer -c 0 -- sset Front mute 
        amixer -c 0 -- sset Surround unmute
        amixer -c 0 -- sset PCM 100%
}
# setup rvm {{{2
setup_rvm(){
        export rvm_ignore_gemrc_issues=1
        if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
                . "$HOME/.rvm/scripts/rvm"
                # export RPROMPT="%{$fg[cyan]%}$($HOME/.rvm/bin/rvm-prompt)%{$reset_color%}"
        elif [[ -s "/etc/profile.d/rvm.sh" ]]; then
                . /etc/profile.d/rvm.sh
                # export RPROMPT="%{$fg[cyan]%}$(/usr/local/rvm/bin/rvm-prompt)%{$reset_color%}"
        fi
}
setup_rvm
# aliases {{{1
# just give a filename with those suffixes and zsh will open it with mplayer
alias -s {mkv,avi,mpg,mpeg,wmv,rmvb}='mplayer' 
# same goes for images
alias -s {gif,jpg,jpeg,png}='feh'

#alias ...='cd ../..'
# Show history
alias history='fc -l 1'
alias x=extract
compdef mp=mplayer
compdef napi=mplayer # ugly, but makes colorfull completions for napi
alias ls="ls -h -G" # --color=tty"
if which ls++ >/dev/null 2>&1; then
        alias ll='TERM=rxvt-unicode ls++ --potsf'
        alias l='TERM=rxvt-unicode ls++'
else
        alias ll='ls -lh -G'
        alias l="ls -h -1 -G"
fi
alias sl="ls" # often screw this up
alias lt="ls -xCt" # show files in columnt sorted by modification
alias mp="mplayer"
alias um="sudo umount"
alias po="ping onet.pl"
alias df="df -h"
alias pacman="sudo pacman-color"
alias tname=term_title
alias vstart="sudo /etc/rc.d/openvpn start"
alias vstop="sudo /etc/rc.d/openvpn stop"
alias vrestart="sudo /etc/rc.d/openvpn restart"
alias '?=bc -l <<<'
alias sluch=headphones
alias glosn=speakers
alias tcm="truecrypt -t"
alias tcu="truecrypt -t -d"
alias serve="python2 -m SimpleHTTPServer 8000"
alias irssi=run_or_attach_irssi
alias wee=run_or_attach_weechat
#alias gvim="STTY='intr \^C' gvim" # C-x mapping fucks up gvim
alias s=smart_sudo
compdef _sudo smart_sudo
# always ask for confirmation for these while using ssh:
alias halt='rconfirm sudo halt'
alias reboot='rconfirm sudo reboot'
alias shutdown='rconfirm sudo shutdown'
autoload zcalc
alias zc=zcalc
alias hist_off='HISTFILE='
alias hist_on='HISTFILE=$HOME/.zsh_history'
alias svim="vim -n -c 'set nobackup'"
alias mktags=make_ctags
alias ips="ip addr | grep -v 127.0.0.1 | awk '\$1 ~ /inet/  { print \$7, \$2 }'"
# git {{{1
# Aliases
alias g='git'
alias gst='git status -sb'
GL_HASH="%C(yellow)%h%Creset"
GL_RELATIVE_TIME="%Cgreen(%ar)%Creset"
GL_AUTHOR="%C(bold blue)<%an>%Creset"
GL_REFS="%C(red)%d%Creset"
GL_SUBJECT="%s"
GL_FORMAT="$GL_HASH $GL_RELATIVE_TIME $GL_AUTHOR $GL_REFS $GL_SUBJECT"
alias gl="git log --abbrev-commit --pretty=oneline --no-merges --decorate --pretty='tformat:${GL_FORMAT}'"
alias gls="git log --abbrev-commit --pretty=oneline --stat --decorate --pretty='tformat:${GL_FORMAT}'"
alias gg="git log --abbrev-commit --pretty=oneline --graph --decorate --pretty='tformat:${GL_FORMAT}'"
alias gp='git push'
alias gf='git fetch'
alias gd='git diff'
alias gdi='git diff --word-diff' # show changes in each word in each line
alias gsh='git stash'
alias gdc='git diff --cached'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=5'
alias gr='git for-each-ref --count=30 --sort=-committerdate refs/remotes/ --format="%(refname:short) (%(authordate))"'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
# directories {{{1
# options {{{2
setopt autocd                  # change to dirs without cd
setopt auto_name_dirs
setopt auto_pushd # auto push to dir stack
setopt pushd_ignore_dups # no dups in dir stack
export DIRSTACKSIZE=100
# dir stack traversal:
alias 1='cd ~1'
alias 2='cd ~2'
alias 3='cd ~3'
alias 4='cd ~4'
alias 5='cd ~5'
alias 6='cd ~6'
alias 7='cd ~7'
alias 8='cd ~8'
alias 9='cd ~9'
alias d='dirs -v' # show directory stack
# grep {{{1
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
# vi-mode {{{1
# VIMODE_I="i"
# function zle-line-init zle-keymap-select {
#     # show nice star digraph when in vi-mode
#     VIMODE_I="${${KEYMAP/vicmd/n}/(main|viins)/i}"
#             zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select
#function zle-keymap-select {
#if [ $TERM = "rxvt-256color" ]; then
        #if [ $KEYMAP = vicmd ]; then
                #echo -ne "\033]12;Red\007"
        #else
                #echo -ne "\033]12;Orange\007"
        #fi
#fi
#}

#zle -N zle-keymap-select

#zle-line-init () {
        #zle -K viins
        #if [ $TERM = "rxvt-256color" ]; then
                #echo -ne "\033]12;Orange\007"
        #fi
#}
#zle -N zle-line-init
bindkey -v
# removing those causes no delay when going into vimode :)
#bindkey -r "^[OA" "^[OB" "^[OC" "^[OD" "^[[A" "^[[B" "^[[C" "^[[D"

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
        source /usr/bin/virtualenvwrapper.sh
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
        eval `keychain --eval --nogui -Q -q ~/.ssh/id_dsa`
fi
# prompt {{{1
# git {{{2
function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


# Checks if working tree is dirty
parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ "$(command git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
          SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    else
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    fi
    if [[ -n $GIT_STATUS ]]; then
      echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the difference between the local and remote branches
git_remote_status() {
    remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
    if [[ -n ${remote} ]] ; then
        ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
        behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE"
        fi
    fi
}

# Checks if there are commits ahead from remote
function git_prompt_ahead() {
  if $(echo "$(command git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
}

# Formats prompt string for current git commit short SHA
function git_prompt_short_sha() {
  SHA=$(command git rev-parse --short HEAD 2> /dev/null) && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

# Formats prompt string for current git commit long SHA
function git_prompt_long_sha() {
  SHA=$(command git rev-parse HEAD 2> /dev/null) && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

# Get the status of the working tree
git_prompt_status() {
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  echo $STATUS
}

#compare the provided version of git to the version installed and on path
#prints 1 if input version <= installed version
#prints -1 otherwise
function git_compare_version() {
  local INPUT_GIT_VERSION=$1;
  local INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)INPUT_GIT_VERSION});
  INSTALLED_GIT_VERSION=($(command git --version 2>/dev/null));
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]});

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 1
}

#this is unlikely to change so make it all statically assigned
POST_1_7_2_GIT=$(git_compare_version "1.7.2")
#clean up the namespace slightly by removing the checker function
unset -f git_compare_version

# prompt itself {{{2
setopt prompt_subst # this option is necessary for prompt colors
autoload -Uz is-at-least
autoload -U add-zsh-hook

PROMPT='%{$fg[yellow]%}λ %m %{$fg[green]%}%3c %{$fg[yellow]%}» $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}± %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%} » %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}●%{$reset_color%}"
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
# path hacking {{{1
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# modeline {{{1
# vim: fdm=marker:fdl=0
