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
rm ~/dotfiles/zsh/environment.sample
cp ~/dotfiles/zsh/user.sample ~/dotfiles/zsh/user
rm ~/dotfiles/zsh/user.sample

echo "-> configuring git"
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
git config --global core.excludesfile '~/dotfiles/zsh/gitignore'

echo "-> Installing Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "-> Installing Node"
brew install node

echo "-> Installing pure-prompt"
npm install --global pure-prompt

echo "-> Installing diff2html"
npm install --global diff2html-cli

echo "-> installing tmux"
brew install tmux
brew install tmate
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "-> installing gpg"
brew install gpg

echo "Get your gpg private and public keys back and run"
echo "  gpg --import private.key"
echo "And then configure git to use your pgp key https://help.github.com/articles/telling-git-about-your-gpg-key/"

echo "\nDone!"
