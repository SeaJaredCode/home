export VISUAL=vim
export EDITOR=$VISUAL
export HISTCONTROL=ignoreboth
export PROMPT_COMMAND='history -a'

force_color_prompt=yes

# Source environment variables
. ~/.environs

#if [ ! -f ~/bin/vsvars.sh ]; then
#    echo "Generating vsvars.sh"
#    . ~/bin/generate_vsvars
#fi

#. ~/bin/vsvars.sh

if [ ! `echo :$PATH: | grep -F :~/bin:` ]; then PATH=$PATH:~/bin; fi;

# Set emacs editing mode
set -o emacs

# Source aliases
. ~/.bash_aliases

if [ -z ${MSYSTEM-x} ]; then
    export SSH_AUTH_SOCK=/tmp/keepass.sock
else
    # Set colorscheme for ls colors. Bootstrap from github repo
    if [ ! -d ~/.dircolors ]; then git clone --depth=1 https://github.com/huyz/dircolors-solarized .dircolors && rm -r .dircolors/.git; fi;

    eval `dircolors .dircolors/dircolors.256dark`
    . .git-completion
    . .git-prompt
    export PS1="\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[0m\]\n\$ "

    eval `ssh-agent -s`
fi;

# Install/configure SPF13 vim setup
SPF=".spf13-vim-3"
if [ ! -d $SPF ]; then
    git clone --depth=1 https://github.com/spf13/spf13-vim.git $SPF
    sh $SPF/bootstrap.sh
fi;
