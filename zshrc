# colors {{{1
autoload colors; colors;
#TODO: figoure out how to make ls_colors_256.zsh not fuck up tmux colors...
#C=$(tput colors)
#if (( C == 256 )); then
        #echo "yay colors"
        #source ~/.zsh/ls_colors_256.zsh
#fi
# named-directories {{{1
# theese are actually aliases for directories:
# ~ $ cd ~rkl
# ~/proj/r/git $
proj=~/proj
dn=~/download
mov=~/mov
dj=~/proj/django
scr=~/proj/scrapy
rukola=~/proj/django/rukola/git
endywia=~/proj/django/endywia/git
rkl=~/proj/r/git
vimrc=~/.vim
zshrc=~/.zsh
xmonad=~/.xmonad
vpn=/etc/openvpn
# completion {{{1
# options {{{2
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol # having C-s availible help a lot in completion->search mode
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word # perform completion from inside the word. Dude.
setopt always_to_end # everything dies...
WORDCHARS=''
autoload -U compinit
compinit 
zmodload -i zsh/complist

# zstyle magic - HERE BE DRAGONS {{{2
bindkey '^i' complete-word # this is *VERY* important read below:
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
zstyle ':completion:*:corrections' format '%B---- %d %F{11}(errors: %e)%f%b'

# colorfull completions & grouping {{{3
zstyle ':completion:*' list-colors "${LS_COLORS}" # colorfull completions
zstyle ':completion:*' group-name '' # separate completions into groups
zstyle ':completion:*' menu select # by default a select-menu for completions

# completion descriptions {{{3
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes' # this one and above will make options have nice docs!
zstyle ':completion:*:options' menu true search # if there is a shitload of options it's more convenient than menu

# separators funn {{{3
zstyle ':completion:*:messages' format "%{$fg[red]%}%d %{$reset_color%}"
zstyle ':completion:*:warnings' format "%{$fg[red]%}Wrong: %d %{$reset_color%}"

# git {{{3
# we want nice git subcommand search inside descriptions
zstyle ':completion:*:complete:git:argument-rest:commands' menu true search
# kill processes {{{3
# stopped working for some reason...
#zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#) #([0-9]#.[0-9]#) ([0-9a-z-]#) ([0-9a-z-]#) \
#        *=$color[green]=$color[red]=$color[yellow]=$color[cyan]=$color[blue]"
arr=( '' 8 88 2 64 32 )
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) ${(l:9*9:: #([^ ]#):)}*${(j:=38;5;:)arr}"
zstyle ':completion:*:*:kill:*:processes' menu true interactive
zstyle ':completion:*:*:*:*:processes' command "ps -A -o pid,pcpu,pmem,cmd --sort=-pcpu"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack named-directories path-directories

# ls / ls++ / cd stuff {{{3
# I like to have autocompletions for ls inserted immediately
zstyle ':completion:*:*:ls:*' menu true
zstyle ':completion:*:*:ls++:*' menu true
zstyle ':completion:*:*:cd:*' menu true # same for cd

# mplayer {{{3
zstyle ':completion:*:*:mplayer:*' menu true # insert autocompletions immediately
zstyle ':completion:*:*:mplayer:*' tag-order files # no urls in completions
# mplayer show only video files ; if no match then regular files; then dirs
zstyle ':completion:*:*:mplayer:*' file-patterns '*.(rmvb|mkv|mpg|wmv|mpeg|avi):video' '*:all-files' '*(-/):directories'

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
zstyle ':completion:*:*:ssh:*:hosts' hosts $_cfg_ssh_hosts  # only hosts from ~/.ssh/config
zstyle ':completion:*:*:scp:*' group-order hosts files # I like to get hosts before files in scp
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
      *.bz2) bunzip $1;;
      *.rar) unrar x $1;;
      *.gz) gunzip $1;;
      *.tar) tar xvf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
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
# wget download prompt {{{2

batch_download(){
        #if [[ -z "$1" ]] 
                #echo "WTF? You missed something, dude"
                #return -1
        while read URL; do
                if [[ -n $URL ]]; then
                        echo "$URL" >> f
                else
                        break
                fi
        done
        case "$1" in
                rapidshare)
                        source $HOME/.rs_download
                        wget --auth-no-challenge --user=$RAPID_USER --password=$RAPID_PASS -i f
                        ;;
                fileserve)
                        source $HOME/.fsrv_download
                        wget --auth-no-challenge --user=$FSRV_USER --password=$FSRV_PASS -i f
                        ;;
                filesonic)
                        if [[ ! -f ~/.fs_cookie ]]; then
                                source $HOME/.fs_download
                                wget --save-cookie="~/.fs_cookie" --post-data="returnto=/&email=$FS_USER&password=$FS_PASS&rememberMe=1" http://filesonic.com/premium?login=1
                        fi
                        wget --load-cookie="~/.fs_cookie" -i f
                        ;;
        esac
        rm f
}
alias rsi="batch_download rapidshare"
alias fsi="batch_download filesonic"
alias fsrv="batch_download fileserve"
# aliases {{{1
# just give a filename with those suffixes and zsh will open it with mplayer
alias -s {mkv,avi,mpg,mpeg,wmv,rmvb}='mplayer' 
# same goes for images
alias -s {gif,jpg,jpeg,png}='feh'

alias ...='cd ../..'
# Show history
alias history='fc -l 1'
alias x=extract
compdef mp=mplayer
alias ls="ls -h --color=tty"
alias ll='ls -lh --color=tty'
alias sl="ls -h --color=tty" # often screw this up
alias llp='ls++' # try ls++ - AWESOME: https://github.com/trapd00r/ls--
alias mp="mplayer"
alias um="sudo umount"
alias po="ping onet.pl"
alias df="df -hT"
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
alias gvim="STTY='intr \^C' gvim" # C-x mapping fucks up gvim
# git {{{1
# Aliases
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=5'

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
# aliases {{{2
#alias ..='cd ..' # not needed with autocd option
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
function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v
# history {{{1
# options {{{2
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="[   ]*:&:bg:fg:clear:hr:hc"

setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space

#setopt SHARE_HISTORY # God no...
setopt APPEND_HISTORY

# branching functions {{{2
# I like to keep a separate shell history for my projects (this makes it easier to
# reuse some older commands and predict is much more sensible in such scenario).
# As I would often forget to enable cusom history - I just set up zsh to do this 
# automatically if it finds a readable-writable-non-zero .zsh_custom_history file in PWD
# If I'm done I can simply type 'hr' to use global zsh history. If I have a fresh project
# I can simply type 'hc' and this will create and checkout new history branch.
# The checkout and branch terminology is borrowed from git - I use it everyday  :)
create_history_branch() {
        if [[ -s .zsh_custom_history && -r .zsh_custom_history && -w .zsh_custom_history ]] 
        then # in case there already is a custom history for current dir
                checkout_history_branch
        else # otherwise let's create a new one!
                echo "Creating a new custom history branch"
                fc -p # pop current global history into stack and create new one
                # below we need to tell zsh where to store the custom history and it's parameters
                HISTFILE=$PWD/.zsh_custom_history
                SAVEHIST=10000
                HISTSIZE=10000
        fi
}

checkout_history_branch() {
        echo "Restoring custom history branch for current dir"
        fc -p $PWD/.zsh_custom_history # put global hist on stack and use this one
        # below we need to tell zsh where to store the custom history and it's parameters
        HISTFILE=$PWD/.zsh_custom_history
        SAVEHIST=10000
        HISTSIZE=10000
}

checkout_master_history_branch() {
        echo "Restoring master history branch"
        fc -P # stash current history and pop global one from stack
}

chpwd() {
        if [[ -s .zsh_custom_history && -r .zsh_custom_history && -w .zsh_custom_history ]] 
        then
                checkout_history_branch
        fi
}
# branching aliases {{{2
alias hr=checkout_master_history_branch
alias hc=create_history_branch
# keybindings {{{1
bindkey -e
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward

bindkey '^c' vi-cmd-mode
stty intr '^x'

## file rename magick
bindkey "^[m" copy-prev-shell-word

# virtualenvwrapper {{{1
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# misc {{{1
## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
## jobs
setopt long_list_jobs
# Make things split words by shell arguments, not spaces
autoload -U select-word-style
select-word-style s
#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS
## pager
export PAGER=less
# complete with sudo {{{1
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo
# keychain {{{1
eval `keychain --eval --nogui -Q -q ~/.ssh/id_dsa`
# prompt {{{1
setopt prompt_subst # this option is necessary for prompt colors
autoload -Uz vcs_info
 
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}≡%{$reset_color%}%{$fg[yellow]%}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}≡%{$reset_color%}%{$fg[yellow]%}"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'
zstyle ':vcs_info:*' enable git svn
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
            zstyle ':vcs_info:*' formats "%{$reset_color%}::%{$fg[yellow]%} (%b%c%u)%{$reset_color%} "
    } else {
    zstyle ':vcs_info:*' formats "%{$reset_color%}::%{$fg[yellow]%} (%b%c%u%{$fg[red]%}∪%{$fg[yellow]%})%{$reset_color%} "
    }
 
    vcs_info
}
 
setopt prompt_subst
#PROMPT='%F{blue}%n@%m %c${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})%% %{$reset_color%}'
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}%c \
${vcs_info_msg_0_}\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '
# vim: fdm=marker:fdl=0
