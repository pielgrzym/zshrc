# completion {{{1
# options {{{2
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end
# styles {{{2
WORDCHARS=''
autoload -U compinit
compinit -i
zmodload -i zsh/complist
## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''
# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)
# use /etc/hosts and known_hosts for hostname completion
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
hosts=( "$_ssh_hosts[@]" "$_etc_hosts[@]" `hostname` localhost)
zstyle ':completion:*:hosts' hosts $hosts
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.oh-my-zsh/cache/
# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# ... unless we really want to.
zstyle '*' single-ignored show

# corrections {{{1
setopt correct_all

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias mkdir='nocorrect mkdir'
alias gist='nocorrect gist'
alias heroku='nocorrect heroku'
alias ebuild='nocorrect ebuild'
alias hpodder='nocorrect hpodder'
# functions {{{1
# extract {{{2
function extract() {
    unset REMOVE_ARCHIVE
    
    if test "$1" = "-r"; then
        REMOVE=1
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
# git prompt {{{2
# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the status of the working tree
git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
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
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  echo $STATUS
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
# aliases {{{1
alias ...='cd ../..'
# Show history
alias history='fc -l 1'
# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up
alias x=extract
compdef mp=mplayer
alias ls="ls -h --color"
alias mp="mplayer"
alias um="sudo umount"
alias ll="ls -lh --color"
alias po="ping onet.pl"
alias eud="emerge --sync && emerge --regen && emerge -uDNav world"
alias df="df -hT"
alias xtr="extract_archive"
alias temp="sensors | egrep \"CPU|Sys\""
alias pacman="sudo pacman-color"
alias tname=term_title
alias vstart="sudo /etc/rc.d/openvpn start"
alias vstop="sudo /etc/rc.d/openvpn stop"
alias vrestart="sudo /etc/rc.d/openvpn restart"
alias '?=bc -l <<<'
alias sluch=headphones
alias glosn=speakers
alias rs="wget --auth-no-challenge --user=447270 --password=475633"
alias filesonic="wget --auth-no-challenge --user=fascikostwo --password=fascikostwosf"
alias tcm="truecrypt -t"
alias tcu="truecrypt -t -d"
alias gvim="STTY='intr \^C' gvim" # C-x mapping fucks up gvim
# git {{{1
# Aliases
alias g='git'
compdef g=git
alias gst='git status'
compdef _git gst=git-status
alias gl='git pull'
compdef _git gl=git-pull
alias gup='git fetch && git rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
alias gd='git diff | mate'
# WTF is mate??
compdef _git gd=git-diff
alias gdv='git diff -w "$@" | vim -R -'
compdef _git gdv=git-diff
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=5'
compdef _git glg=git-log

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git

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
compdef ggpull=git
alias ggpush='git push origin $(current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git
# directories {{{1
# options {{{2
setopt autocd                  # change to dirs without cd
setopt auto_name_dirs
setopt auto_pushd # auto push to dir stack
setopt pushd_ignore_dups # no dups in dir stack
export DIRSTACKSIZE=100
# aliases {{{2
alias ..='cd ..'
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'
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
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="[   ]*:&:bg:fg:clear"

setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space

#setopt SHARE_HISTORY
setopt APPEND_HISTORY
# keybindings {{{1
autoload -U compinit
compinit -i

bindkey -e
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward

bindkey '^c' vi-cmd-mode
stty intr '^x'

# virtualenvwrapper {{{1
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# misc {{{1
## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER=less
# spectrum {{{1
source ~/.zsh/spectrum.zsh
# termsupport {{{1
#usage: title short_tab_title looooooooooooooooooooooggggggg_windows_title
#http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
#Fully support screen, iterm, and probably most modern xterm and rxvt
#Limited support for Apple Terminal (Terminal can't set window or tab separately)
function title {
  if [[ "$TERM" == "screen" ]]; then 
    print -Pn "\ek$1\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ ($TERM =~ "^xterm") ]] || [[ ($TERM == "rxvt") ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2\a" #set window name
    print -Pn "\e]1;$1\a" #set icon (=tab) name (will override window name on broken terminal)
  fi
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m: %~"

#Appears when you have the prompt
function precmd {
  if [ "$DISABLE_AUTO_TITLE" != "true" ]; then
    title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
  fi
}

#Appears at the beginning of (and during) of command execution
function preexec {
  if [ "$DISABLE_AUTO_TITLE" != "true" ]; then
    local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
    title "$CMD" "%100>...>$2%<<"
  fi
}
# theme and appearance {{{1
# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"
#export LS_COLORS

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
PS1="%n@%m:%~%# "

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
ZSH_THEME_GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# Setup the prompt with pretty colors
setopt prompt_subst
# prompt {{{1
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}%c \
$(git_prompt_info)\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}:: %{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
# vim: fdm=marker:fdl=1
