#! /bin/sh

echo "-> Linking vim config files"
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

echo "-> Installing Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim

echo "-> Installing Plugins"
vim +PluginInstall +qall

echo "-> Installing YouCompleteMe"
cd vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py
cd ../../..

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
asdf install nodejs 11.8.0
asdf local nodejs 11.8.0

echo "-> Installing diff2html"
npm install --global diff2html-cli

echo "-> installing gpg"
brew install gpg

echo "Get your gpg private and public keys back and run"
echo "  gpg --import private.key"
echo "And then configure git to use your pgp key https://help.github.com/articles/telling-git-about-your-gpg-key/"

echo "\nDone!"
