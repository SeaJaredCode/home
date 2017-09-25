[ -r $HOME/.bashrc ] && . $HOME/.bashrc

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
        [ ! -d ~/.solarized ] && git clone --depth=1 https://github.com/altercation/solarized .solarized && rm -r .solarized/.git
        # Have to install the solarized theme manually to iterm2
        add_to_PATH ~/Library/Python/3.6/bin /Library/Frameworks/Python.framework/Versions/3.6/bin
        ;;
    msys)
        ;;
    linux-gnu)
        if [ -d $HOME/.rvm ]; then
            add_to_PATH "$HOME/.rvm/bin"
            [ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
        fi

        [ ! -d ~/.dircolors ] && git clone --depth=1 https://github.com/huyz/dircolors-solarized .dircolors && rm -r .dircolors/.git
        ;;
esac

