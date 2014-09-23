# global {{{1
# just give a filename with those suffixes and zsh will open it with mplayer
alias -s {mkv,avi,mpg,mpeg,wmv,rmvb}='mplayer' 
# same goes for images
alias -s {gif,jpg,jpeg,png}='feh'

alias tmux="TERM=screen-256color-bce tmux"
#alias ...='cd ../..'
# Show history
alias history='fc -l 1'
alias x=extract
compdef mp=mplayer
compdef napi=mplayer # ugly, but makes colorfull completions for napi
alias ls="ls -h --color=tty"
if which ls++ >/dev/null 2>&1; then
        alias ll='TERM=rxvt-unicode ls++ --potsf'
        alias l='TERM=rxvt-unicode ls++'
else
        alias ll='ls -lh --color=tty'
        alias l="ls -h -1 --color=tty"
fi
alias lta='tree -L 2'
alias lt='tree -L 2 -d'
alias sl="ls" # often screw this up
#alias lt="ls -xCt" # show files in columnt sorted by modification
alias mp="mplayer"
alias um="sudo umount"
alias po="ping onet.pl"
alias df="df -hT"
alias pacman="sudo pacman-color"
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
alias ips="ip addr | grep -v 127.0.0.1 | awk '\$1 ~ /inet/  { print \$7, \$2 }'"
alias dssh="dropship ssh"
# git {{{1
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
alias glast="git --no-pager log --abbrev-commit --no-merges --pretty=oneline --stat --decorate --pretty='tformat:${GL_FORMAT}'"
alias glo="git --no-pager log --oneline --decorate --graph --abbrev-commit --date=relative --pretty='tformat:${GL_FORMAT}' -n 10"
alias gloa="git log --oneline --decorate --graph --abbrev-commit --date=relative --pretty='tformat:${FORMAT}'"
alias gla="git log --all --oneline --decorate --graph --abbrev-commit --date=relative --pretty='tformat:${FORMAT}'"
glastupstream(){
        glast ..origin/$(current_branch) $*
}
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
# modeline {{{1
# vim: fdm=marker:fdl=0
