### Bootstrapping
# Install/configure SPF13 vim setup
_PROFILE=1
SPF="$HOME/.spf13-vim-3"
if [ ! -d $SPF ]; then
    git clone --depth=1 https://github.com/spf13/spf13-vim.git $SPF
    [ -z ${MSYSTEM+x} ] && sh $SPF/bootstrap.sh || printf "spf13 downloaded. Please complete installation using one of the bootstrapping scripts within ~/.spf13-vim-3\n"
fi

[ -s ~/.git-completion ] || curl -o .git-completion "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
[ -s ~/.git-prompt ] || curl -o .git-prompt "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

case $OSTYPE in
    darwin*)
        # Have to install themes manually to iterm2
        [ ! -d ~/.solarized ] && git clone --depth=1 https://github.com/altercation/solarized .solarized && rm -rf .solarized/.git
        [ ! -d ~/.iterm2/schemes ] && git clone --depth=1 https://github.com/mbadolato/iTerm2-Color-Schemes .iterm2/schemes  && rm -rf .iterm2/schemes/.git
        ;;
    msys)
        ;;
    linux-gnu)
        [ ! -d ~/.dircolors ] && git clone --depth=1 https://github.com/huyz/dircolors-solarized .dircolors && rm -r .dircolors/.git
        ;;
esac

[ -r $HOME/.bashrc ] && source $HOME/.bashrc


source /Users/jared/.docker/init-bash.sh || true # Added by Docker Desktop
