### General settings
force_color_prompt=yes

# Set emacs editing mode
set -o emacs

# Set cursor type
echo -e -n "\x1b[\x35 q"

# Source a local init file
if [ -e ~/.bashrc_$HOSTNAME ]; then source ~/.bashrc_$HOSTNAME >> /dev/null 2>&1; fi

# Source environment variables
. ~/.environs

# Source aliases
. ~/.bash_aliases

# Source functions
. ~/.bash_fns

# Add ~/bin to path
add_to_PATH ~/bin
add_to_PATH ~/.local/bin

# Set color theme
if [ -d ~/.dircolors ]; then eval `dircolors ~/.dircolors/dircolors.256dark`; fi;

has_git=$(which git >> /dev/null && echo $?)
[ $has_git ] && [ -f ~/.git-completion ] && . ~/.git-completion

case $OSTYPE in
darwin*)
    [ -f ~/.bashrc_darwin ] && . ~/.bashrc_darwin
    ;;
*)
    [ ! -z ${MSYSTEM} ] && [ -f ~/.bashrc_msys ] && . ~/.bashrc_msys

    if [ $has_git ] && [ -f ~/.git-prompt ]; then
        . ~/.git-prompt
        export PS1="\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[0m\]\n\$ "
    fi
    ;;
esac

if [ -d $HOME/.rvm ]; then
    add_to_PATH "$HOME/.rvm/bin"
    # Load RVM into a shell session as a function
    [ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
fi

if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

