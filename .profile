### Bootstrapping
# Install/configure SPF13 vim setup
SPF="$HOME/.spf13-vim-3"
if [ ! -d $SPF ]; then
    git clone --depth=1 https://github.com/spf13/spf13-vim.git $SPF
    [ -z ${MSYSTEM+x} ] && sh $SPF/bootstrap.sh || printf "spf13 downloaded. Please complete installation using one of the bootstrapping scripts within ~/.spf13-vim-3\n"
fi

[ -s ~/.git-completion ] || curl -o .git-completion "https://github.com/git/git/blob/master/contrib/completion/git-completion.bash"
[ -s ~/.git-prompt ] || curl -o .git-prompt "https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh"

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

[ -r $HOME/.bashrc ] && . $HOME/.bashrc

