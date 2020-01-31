#! /bin/sh

echo "-> Linking vim config files"
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

echo "-> Updating xcode command line tools"
xcode-select --install

echo "-> Linking zsh config files"
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
cp ~/dotfiles/zsh/environment.sample ~/dotfiles/zsh/environment
cp ~/dotfiles/zsh/user.sample ~/dotfiles/zsh/user
cp ~/dotfiles/zsh/ssh.sample ~/dotfiles/zsh/ssh

echo "-> Configuring git"
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
git config --global core.excludesfile '~/dotfiles/zsh/gitignore'

echo "-> Installing Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "-> Installing brew libraries"
brew bundle

echo "-> Configuring fzf"
$(brew --prefix)/opt/fzf/install

echo "-> Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
cd -

source ~/.zshrc

echo "-> Installing java"
asdf plugin-add java
asdf install java openjdk-11.0.1
asdf global java openjdk-11.0.1

echo "-> Installing ruby"
asdf plugin-add ruby
asdf install ruby 2.6.2
asdf global ruby 2.6.2

echo "-> Installing erlang"
asdf plugin-add erlang
asdf install erlang 21.1
asdf global erlang 21.1

echo "-> Installing elixir"
asdf plugin-add elixir
asdf install elixir 1.8
asdf global elixir 1.8

echo "-> Installing node.js"
asdf plugin-add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 11.8.0
asdf global nodejs 11.8.0

echo "-> Installing golang"
asdf plugin-add golang
asdf install golang 1.11
asdf global golang 1.11
mkdir $HOME/code
mkdir $HOME/code/go
export GOPATH=$HOME/code/go
export PATH="$GOPATH"/bin:"$PATH"
export GO111MODULE=on

echo "-> Installing python"
asdf plugin-add python
asdf install python 3.7.4
asdf install python 2.7.16
asdf global python 3.7.4 2.7.16
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm ./get-pyp.py

echo "-> Installing spaceshipt prompt"
npm install -g spaceship-prompt

echo "-> Installing neovim from source"
brew install ninja libtool automake cmake pkg-config gettext
git clone https://github.com/neovim/neovim.git && cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/usr/local/bin SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk MACOSX_DEPLOYMENT_TARGET=10.14
make install
cp build/bin/nvim /usr/local/bin/nvim
cd ..
rm -rf ~/neovim
pip install --user neovim

echo "-> Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "-> Installing Plugins"
nvim +PlugInstall +qall

echo "-> Installing coc.nvim and language servers"
ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

echo "\t-> Installing gopls"
go get -u golang.org/x/tools/cmd/gopls

echo "\t-> Installing solargraph"
gem install solargraph

echo "-> Installing diff2html"
npm install --global diff2html-cli

echo "-> Installing tldr"
mkdir -p ~/bin
curl -o ~/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
chmod +x ~/bin/tldr

echo "-> Installing gpg"
brew install gpg

echo "Get your gpg private and public keys back and run"
echo "  gpg --import private.key"
echo "And then configure git to use your pgp key https://help.github.com/articles/telling-git-about-your-gpg-key/"

echo "\nDone!"
