alias fetch='git fetch -p --all'
alias rm_git_message='rm ~/.vimswap/* .git/COM* 2> /dev/null'

LS='ls'
DF='df'
case $OSTYPE in
    darwin*)
        LS='gls'
        DF='gdf'

        alias dircolors='gdircolors'
        alias cdg='cd ~/Projects'
        alias cdm='cd ~/Projects/mono'
        alias cdr='cd "$(get_git_root)"'
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

which kubectl > /dev/null 2>&1 && alias kc='kubectl'

# bash functions that are essentially aliases with parameters
aws-refresh-token() { eval `aws-sts $1`; }

alias login_docker="aws ecr get-login --no-include-email --region us-west-2|cut -d ' ' -f 6| docker login -u AWS --password-stdin https://324842975178.dkr.ecr.us-west-2.amazonaws.com"
alias amm="amm --no-remote-logging"
alias gource="gource --auto-skip-seconds 0.1 --seconds-per-day 0.5 --camera-mode track --dont-stop"
[ -d /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/ ] && alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias yd="ydiff -s -w0"

# Claude Code
# Core launcher: standard flags (bypass perms + Chrome + remote control) plus any args.
# (--dangerously-skip-permissions already bypasses everything, so no --permission-mode.)
c2() {
    claude --dangerously-skip-permissions --chrome --remote-control "$@"
}
# Safer variant: auto permission mode instead of a full bypass.
c2a() {
    claude --permission-mode auto --chrome --remote-control "$@"
}

# Codex CLI: equivalent unrestricted launcher for externally sandboxed sessions.
cx() {
    codex --dangerously-bypass-approvals-and-sandbox "$@"
}

# catwrangler: cd into the project (persists), set AWS + breakglass-shim PATH
# for the claude process only, then launch via c2. Extra args pass through.
cw() {
    cd /Volumes/Projects/catwrangler || return
    (
        export PATH="/Volumes/Projects/catwrangler/.claude/breakglass/shims:$PATH"
        export AWS_PROFILE=cw AWS_REGION=us-east-1
        c2 "$@"
    )
}

# CatWrangler through Codex: same project, AWS profile, and break-glass shim setup as cw.
cwx() {
    cd /Volumes/Projects/catwrangler || return
    (
        export PATH="/Volumes/Projects/catwrangler/.claude/breakglass/shims:$PATH"
        export AWS_PROFILE=cw AWS_REGION=us-east-1
        cx "$@"
    )
}
