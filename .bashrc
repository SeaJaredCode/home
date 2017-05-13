force_color_prompt=yes

# Set emacs editing mode
set -o emacs

# Source environment variables
. ~/.environs

# Add ~/bin to path
if [ ! `echo :$PATH: | grep -F :~/bin:` ]; then PATH=$PATH:~/bin; fi;

if [ ${MSYSTEM-x} != x ]; then
    if [ ! -f ~/bin/vsvars.sh ]; then
        echo "Generating vsvars.sh"
        . ~/bin/generate_vsvars
    fi

    . ~/bin/vsvars.sh

    export SSH_AUTH_SOCK=/tmp/keepass.sock
else
    if [ ! -d ~/.dircolors ]; then eval `dircolors ~/.dircolors/dircolors.256dark`; fi;

    . ~/.git-completion
    . ~/.git-prompt

    export PS1="\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[0m\]\n\$ "
fi;

# Source aliases
. ~/.bash_aliases
