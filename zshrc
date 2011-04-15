# colors {{{1
autoload colors; colors;
LS_COLORS='bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;148;1:pi=38;5;126:fi=38;5;253:ln=target:mh=38;5;220;1:no=38;5;254:or=48;5;196;38;5;232;1:ow=38;5;178;1:sg=38;5;137;1:su=38;5;137:so=38;5;197:st=38;5;208;1:tw=38;5;220;1:*.PL=38;5;160:*.asm=38;5;240;1:*.awk=38;5;148;1:*.bash=38;5;173:*.c=38;5;110:*.cfg=1:*.coffee=38;5;94;1:*.conf=1:*.cpp=38;5;24;1:*.cs=38;5;74;1:*.css=38;5;91:*.csv=38;5;78:*.diff=48;5;197;38;5;232:*.enc=38;5;192;3:*.eps=38;5;192:*.etx=38;5;172:*.ex=38;5;148;1:*.example=38;5;225;1:*.git=38;5;197:*.gitignore=38;5;240:*.go=38;5;36;1:*.h=38;5;81:*.hs=38;5;159:*.htm=38;5;125;1:*.html=38;5;125;1:*.info=38;5;101:*.ini=38;5;122:*.java=38;5;142;1:*.jhtm=38;5;125;1:*.js=38;5;42:*.jsm=38;5;42:*.jsm=38;5;42:*.json=38;5;199:*.jsp=38;5;45:*.lisp=38;5;204;1:*.log=38;5;190:*.lua=38;5;34;1:*.map=38;5;58;3:*.markdown=38;5;184:*.md=38;5;184:*.mf=38;5;220;3:*.mfasl=38;5;73:*.mi=38;5;124:*.mkd=38;5;184:*.mtx=38;5;36;3:*.nfo=38;5;220:*.pacnew=38;5;33:*.patch=48;5;197;38;5;232:*.pc=38;5;100:*.pfa=38;5;43:*.php=38;5;93:*.pid=38;5;160:*.pl=38;5;214:*.pm=38;5;197;1:*.pod=38;5;172;1:*.py=38;5;41:*.rb=38;5;192:*.rdf=38;5;144:*.ru=38;5;142:*.sed=38;5;130;1:*.sfv=38;5;197:*.sh=38;5;113:*.signature=38;5;206:*.sty=38;5;58:*.sug=38;5;44:*.t=38;5;28;1:*.tcl=38;5;64;1:*.tdy=38;5;214:*.tex=38;5;172:*.textile=38;5;106:*.tfm=38;5;64:*.tfnt=38;5;140:*.theme=38;5;109:*.txt=38;5;192:*.urlview=38;5;85:*.vim=1:*.xml=38;5;199:*.yml=38;5;208:*.zsh=38;5;173:*.1=38;5;196;1:*.1p=38;5;160:*.3p=38;5;160:*.old=38;5;242:*.out=38;5;46;1:*.bmp=38;5;62:*.cdr=38;5;59:*.gif=38;5;72:*.ico=38;5;73:*.jpeg=38;5;66:*.jpg=38;5;66:*.JPG=38;5;66:*.png=38;5;68;1:*.svg=38;5;24;1:*.xpm=38;5;36:*.32x=38;5;137:*.A64=38;5;82:*.a00=38;5;11:*.a52=38;5;112:*.a64=38;5;82:*.a78=38;5;112:*.adf=38;5;35:*.atr=38;5;213:*.cdi=38;5;124:*.fm2=38;5;35:*.gb=38;5;203:*.gba=38;5;205:*.gbc=38;5;204:*.gel=38;5;83:*.gg=38;5;138:*.ggl=38;5;83:*.j64=38;5;102:*.nds=38;5;193:*.nes=38;5;160:*.rom=38;5;59;1:*.sav=38;5;220:*.sms=38;5;33:*.st=38;5;208;1:*.iso=38;5;124:*.nrg=38;5;124:*.qcow=38;5;141:*.MOV=38;5;42:*.avi=38;5;114:*.flv=38;5;131:*.mkv=38;5;202:*.mov=38;5;42:*.mp4=38;5;124:*.mpg=38;5;38:*.mpeg=38;5;38:*.ogv=38;5;94:*.rmvb=38;5;112:*.sample=38;5;130;1:*.ts=38;5;39:*.wmv=38;5;113:*.S3M=38;5;71;1:*.cue=38;5;112:*.dat=38;5;165:*.fcm=38;5;41:*.flac=38;5;166;1:*.m3u=38;5;172:*.m4=38;5;196;3:*.m4a=38;5;137;1:*.mod=38;5;72:*.mp3=38;5;191:*.s3m=38;5;71;1:*.sid=38;5;69;1:*.spl=38;5;173:*.afm=38;5;58:*.pfb=38;5;58:*.pfm=38;5;58:*.ttf=48;5;1:*.pcf=38;5;65:*.psf=38;5;64:*.bak=38;5;41;1:*.bin=38;5;249:*.swo=38;5;236:*.swp=38;5;241:*.tmp=38;5;244:*.un~=38;5;240:*.db=38;5;60:*.dump=38;5;119:*.sqlite=38;5;60:*.typelib=38;5;60:*.7z=38;5;40:*.a=38;5;46:*.arj=38;5;41:*.cbr=38;5;140:*.cbz=38;5;140:*.chm=38;5;144:*.jad=38;5;50:*.jar=38;5;51:*.part=38;5;240;1:*.pdf=38;5;203:*.r00=38;5;233:*.r01=38;5;234:*.r02=38;5;235:*.r03=38;5;236:*.r04=38;5;237:*.r05=38;5;238:*.r06=38;5;239:*.r07=38;5;240:*.r08=38;5;241:*.r09=38;5;242:*.r10=38;5;243:*.r100=38;5;244:*.r101=38;5;240:*.r102=38;5;241:*.r103=38;5;242:*.r104=38;5;243:*.r105=38;5;244:*.r106=38;5;245:*.r107=38;5;246:*.r108=38;5;247:*.r109=38;5;248:*.r11=38;5;244:*.r110=38;5;249:*.r111=38;5;250:*.r112=38;5;251:*.r113=38;5;252:*.r114=38;5;253:*.r115=38;5;254:*.r116=38;5;255:*.r12=38;5;245:*.r13=38;5;246:*.r14=38;5;247:*.r15=38;5;248:*.r16=38;5;249:*.r17=38;5;250:*.r18=38;5;251:*.r19=38;5;252:*.r20=38;5;253:*.r21=38;5;254:*.r22=38;5;255:*.r25=38;5;255:*.r26=38;5;254:*.r27=38;5;253:*.r28=38;5;252:*.r29=38;5;251:*.r30=38;5;250:*.r31=38;5;249:*.r32=38;5;248:*.r33=38;5;247:*.r34=38;5;246:*.r35=38;5;245:*.r36=38;5;244:*.r37=38;5;243:*.r38=38;5;242:*.r39=38;5;241:*.r40=38;5;240:*.r41=38;5;239:*.r42=38;5;238:*.r43=38;5;237:*.r44=38;5;236:*.r45=38;5;235:*.r46=38;5;234:*.r47=38;5;233:*.r48=38;5;234:*.r49=38;5;235:*.r50=38;5;236:*.r51=38;5;237:*.r52=38;5;238:*.r53=38;5;239:*.r54=38;5;240:*.r55=38;5;241:*.r56=38;5;242:*.r57=38;5;243:*.r58=38;5;244:*.r59=38;5;245:*.r60=38;5;246:*.r61=38;5;247:*.r62=38;5;248:*.r63=38;5;249:*.r64=38;5;250:*.r65=38;5;251:*.r66=38;5;252:*.r67=38;5;253:*.r68=38;5;254:*.r69=38;5;255:*.r69=38;5;255:*.r70=38;5;254:*.r71=38;5;253:*.r72=38;5;252:*.r73=38;5;251:*.r74=38;5;250:*.r75=38;5;249:*.r76=38;5;248:*.r77=38;5;247:*.r78=38;5;246:*.r79=38;5;245:*.r80=38;5;244:*.r81=38;5;243:*.r82=38;5;242:*.r83=38;5;241:*.r84=38;5;240:*.r85=38;5;239:*.r86=38;5;238:*.r87=38;5;237:*.r88=38;5;236:*.r89=38;5;235:*.r90=38;5;234:*.r91=38;5;235:*.r92=38;5;236:*.r93=38;5;237:*.r94=38;5;238:*.r95=38;5;239:*.r96=38;5;240:*.r97=38;5;241:*.r98=38;5;242:*.r99=38;5;243:*.rar=38;5;106;1:*.tar=38;5;118:*.tar.gz=38;5;34:*.tgz=38;5;35;1:*.xz=38;5;118:*.zip=38;5;41:*.SKIP=38;5;244:*.def=38;5;136:*.directory=38;5;83:*.err=38;5;160;1:*.error=38;5;160;1:*.pi=38;5;126:*.properties=38;5;197;1:*.torrent=38;5;58:';
export LS_COLORS
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
zstyle ':completion:*:corrections' format '%B---- %d %F{11}(errors: %e)%f%b'
# colorfull completions & grouping {{{3
# evil -> zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorfull completions
zstyle ':completion:*:*:*:argument-rest:*' list-colors ${(s.:.)LS_COLORS} # colorfull completions fast
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
zstyle ':completion:*:*:kill:*:processes' menu true interactive
zstyle ':completion:*:*:*:*:processes' command "ps -A -o pid,pcpu,pmem,cmd --sort=-pcpu"

# ls / ls++ / cd stuff {{{3
# I like to have autocompletions for ls inserted immediately
zstyle ':completion:*:*:ls:*' menu true
zstyle ':completion:*:*:ls++:*' menu true
zstyle ':completion:*:*:cd:*' menu true # same for cd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack named-directories path-directories

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
zstyle ':completion:*:*:(ssh|scp):*:hosts' hosts $_cfg_ssh_hosts  # only hosts from ~/.ssh/config
zstyle ':completion:*:*:scp:*' menu true # rather no menu...
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
                        if [[ ! -f ~/.fsrv_cookie ]]; then
                                source $HOME/.fsrv_download
                                wget --save-cookie="$HOME/.fsrv_cookie" --post-data="loginUserName=$FSRV_USER&loginUserPassword=$FSRV_PASS&autoLogin=1" "http://www.fileserve.com/login.php"
                        fi
                        wget --load-cookie="$HOME/.fsrv_cookie" -i f
                        ;;
                filesonic)
                        if [[ ! -f ~/.fs_cookie ]]; then
                                source $HOME/.fs_download
                                wget --save-cookie="$HOME/.fs_cookie" --post-data="returnto=/&email=$FS_USER&password=$FS_PASS&rememberMe=1" http://www.filesonic.com/user/login
                        fi
                        wget --load-cookie="$HOME/.fs_cookie" -i f
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

#alias ...='cd ../..'
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
#alias gvim="STTY='intr \^C' gvim" # C-x mapping fucks up gvim
# git {{{1
# Aliases
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gdc='git diff --cached'
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
alias ..='cd ..' # not needed with autocd option
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
    # show nice star digraph when in vi-mode
    VIMODE_I="${${KEYMAP/vicmd/$fg[yellow]★$reset_color }/(main|viins)/}"
            zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
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
bindkey -r "^[OA" "^[OB" "^[OC" "^[OD" "^[[A" "^[[B" "^[[C" "^[[D"

# history {{{1
# options {{{2
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
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
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward

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
# misc {{{1
## smart urls
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
# complete with sudo {{{1
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^X^s" insert-sudo
bindkey '^i' complete-word # this is *VERY* important read below:
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
 
#PROMPT='%F{blue}%n@%m %c${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})%% %{$reset_color%}'
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}%c \
${vcs_info_msg_0_}\
%{$fg[red]%}%(!.#.»)%{$reset_color%} ${VIMODE_I}'
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '
# vim: fdm=marker:fdl=0
