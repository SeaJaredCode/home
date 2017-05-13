alias fetch='git fetch -p --all'
alias rm_git_message='rm ~/.vimswap/* .git/COM* 2> /dev/null'
alias cdmain='cd /c/git/main'
alias cduser='cd /c/git/users/jstiff'
alias cdgit='cd /c/git'
alias cdalt='cd /c/git/alt-main'
if [ -z ${MSYSTEM-x} ]; then
    alias ca-client='winpty ca-client'
fi;
alias ls='ls -F --color=auto --show-control-chars'
alias ll='ls -al'
alias l='less'
alias mkdir='mkdir -m 755'
