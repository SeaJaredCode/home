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
        alias cdm='cd ~/Projects/mono'
        ;;
    msys)
        alias cdmain='cd /c/git/main'
        alias cduser='cd /c/git/users/jstiff'
        alias cdgit='cd /c/git'
        alias cdalt='cd /c/git/alt-main'
        ;;
    linux-gnu)
        [ $(grep -qi Microsoft /proc/sys/kernel/osrelease 2> /dev/null) ] && alias ca-client='winpty ca-client'
        ;;
esac

alias check='sudo mtr google.com'
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
alias ghist='history | grep '

alias top='htop'
alias myip='curl http://ipecho.net/plain; echo'

# bash functions that are essentially aliases with parameters
aws-refresh-token() { eval `aws-sts $1`; }

alias login_docker="aws ecr get-login --no-include-email --region us-west-2|cut -d ' ' -f 6| docker login -u AWS --password-stdin https://324842975178.dkr.ecr.us-west-2.amazonaws.com"
alias amm="amm --no-remote-logging"
alias gource="gource --auto-skip-seconds 0.1 --seconds-per-day 0.5 --camera-mode track --dont-stop"
