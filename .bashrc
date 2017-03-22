# Source environment variables
. ~/.environs

if [ ! -f ~/bin/vsvars.sh ]; then
    echo "Generating vsvars.sh"
    . ~/bin/generate_vsvars
fi

. ~/bin/vsvars.sh

# Set emacs editing mode
set -o emacs

# Source aliases
. ~/.bash_aliases

export SSH_AUTH_SOCK=/tmp/keepass.sock
#export GIT_SSH=/bin/plink
