# options {{{1
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
# zstyle magic - HERE BE DRAGONS {{{1
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
zstyle ':completion:*:*:*:*:processes' command "ps -A -o pid,pcpu,pmem,cmd --sort=-pcpu"
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
[ -r $HOME/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
hosts=( "$_ssh_hosts[@]" "$_etc_hosts[@]" `hostname` localhost)
zstyle ':completion:*:*:*:*:hosts' hosts $hosts
# above host completion is nice, but for ssh I want only hosts from .ssh/config - doesn't work :(
[ -r $HOME/.ssh/known_hosts ] && _cfg_ssh_hosts=(${${${(M)${(f)"$(<$HOME/.ssh/config)"}##Host *}#Host }#\*})
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
# modeline {{{1
# vim: fdm=marker:fdl=0
