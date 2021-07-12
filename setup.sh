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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "-> Installing brew libraries"
brew bundle

echo "-> Installing gpg"
brew install gpg

echo "-> Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
cd -

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
asdf install nodejs 16.4.2
asdf global nodejs 16.4.2
npm install -g yarn
asdf reshim

echo "-> Installing golang"
asdf plugin-add golang
asdf install golang 1.16.5
asdf global golang 1.16.5
mkdir $HOME/code
mkdir $HOME/code/go
export GOPATH=$HOME/code/go
export PATH="$GOPATH"/bin:"$PATH"
asdf reshim

echo "-> Installing python"
asdf plugin-add python
asdf install python 3.9.6
asdf install python 2.7.16
asdf global python 3.9.6 2.7.16
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm ./get-pyp.py

echo "-> Installing spaceshipt prompt"
npm install -g spaceship-prompt

echo "-> Installing neovim"
asdf plugin add neovim
asdf install neovim nightly
asdf global neovim nightly

pip install --user neovim
gem install neovim
npm install -g neovim

echo "-> Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "-> Installing Plugins"
nvim +PlugInstall +qall

echo "-> Installing coc.nvim and language servers"
ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

echo "\t-> Installing solargraph"
gem install solargraph

echo "-> Installing diff2html"
npm install --global diff2html-cli

echo "Get your gpg private and public keys back and run"
echo "  gpg --import private.key"
echo "And then configure git to use your pgp key https://help.github.com/articles/telling-git-about-your-gpg-key/"

echo "\nDone!"
