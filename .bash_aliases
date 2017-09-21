alias fetch='git fetch -p --all'
alias rm_git_message='rm ~/.vimswap/* .git/COM* 2> /dev/null'

LS='ls'
DF='df'
case $OSTYPE in
    darwin*)
        LS='gls'
        DF='gdf'

        alias dircolors='gdircolors'
        alias cdgit='cd ~/Projects'
        ;;
    msys)
        alias cdmain='cd /c/git/main'
        alias cduser='cd /c/git/users/jstiff'
        alias cdgit='cd /c/git'
        alias cdalt='cd /c/git/alt-main'
        ;;
    linux-gnu)
        [ $('grep -qi Microsoft /proc/sys/kernel/osrelease 2> /dev/null') ] && alias ca-client='winpty ca-client'
        ;;
esac

alias ls='$LS -F --color=auto --show-control-chars'
alias ll='ls -ahl'
alias lsl='ll --color | less'
alias sl='ls'
alias l='less'
alias v='vim'
alias mkdir='mkdir -pv -m 755'
alias df='$DF -Tha --total'
alias cd..='cd ..'
alias ..='cd ..'
alias .='source'
alias ghist='history | grep '

alias top='htop'
alias myip='curl http://ipencho.net/plain; echo'
