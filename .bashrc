force_color_prompt=yes

# Set emacs editing mode
set -o emacs

# Source environment variables
. ~/.environs

# Source aliases
. ~/.bash_aliases

# Idempotent fn to add dir to $PATH
add_to_PATH () {
    for d; do
        d=$(cd -- "$d" && { pwd -P || pwd;  }) 2>/dev/null  # canonicalize symbolic links
        if [ -z "$d"  ]; then continue; fi  # skip nonexistent directory

        case ":$PATH:" in
            *":$d:"*) :;;
            *) export PATH=$PATH:$d;;
        esac
    done
}

# Add ~/bin to path
add_to_PATH ~/bin

if [ ${MSYSTEM-x} != x ]; then
    if [ ! -f ~/bin/vsvars.sh ]; then
        echo "Generating vsvars.sh"
        . ~/bin/generate_vsvars
    fi

    . ~/bin/vsvars.sh

    export SSH_AUTH_SOCK=/tmp/keepass.sock
else
    if [ -d ~/.dircolors ]; then eval `dircolors ~/.dircolors/dircolors.256dark`; fi;

    . ~/.git-completion
    . ~/.git-prompt

    export PS1="\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[0m\]\n\$ "
fi;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
