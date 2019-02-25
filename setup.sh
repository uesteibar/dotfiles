#! /bin/sh

echo "-> Linking vim config files"
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

echo "-> Installing Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim

echo "-> Installing Plugins"
vim +PluginInstall +qall

echo "-> Linking zsh config files"
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
cp ~/dotfiles/zsh/environment.sample ~/dotfiles/zsh/environment
cp ~/dotfiles/zsh/user.sample ~/dotfiles/zsh/user
cp ~/dotfiles/zsh/ssh.sample ~/dotfiles/zsh/ssh

echo "-> configuring git"
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
git config --global core.excludesfile '~/dotfiles/zsh/gitignore'

echo "-> Installing Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "-> Installing brew libraries"
brew bundle

echo "-> Configuring fzf"
$(brew --prefix)/opt/fzf/install

echo "-> Installing spaceshipt prompt"
npm install -g spaceship-prompt

echo "-> Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
cd -

source ~/.zshrc

echo "-> installing java"
asdf plugin-add java
asdf install java openjdk-11.0.1
asdf global java openjdk-11.0.1

echo "-> installing ruby"
asdf plugin-add ruby
asdf install ruby 2.6
asdf global ruby 2.6

echo "-> installing erlang"
asdf plugin-add erlang
asdf install erlang 21.1
asdf global erlang 21.1

echo "-> installing elixir"
asdf plugin-add elixir
asdf install elixir 1.8
asdf global elixir 1.8

echo "-> installing node.js"
asdf plugin-add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 11.8.0
asdf global nodejs 11.8.0

echo "-> installing golang"
asdf plugin-add golang
asdf install golang 1.11
asdf global golang 1.11

echo "-> installing python"
asdf plugin-add python
asdf install python pypy3.6-7.0.0
asdf global python pypy3.6-7.0.0

echo "-> Setting up neovim"
pip install --user neovim

echo "-> Installing diff2html"
npm install --global diff2html-cli

echo "-> installing gpg"
brew install gpg

echo "Get your gpg private and public keys back and run"
echo "  gpg --import private.key"
echo "And then configure git to use your pgp key https://help.github.com/articles/telling-git-about-your-gpg-key/"

echo "\nDone!"
