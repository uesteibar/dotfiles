#! /bin/sh

echo "-> Linking vim config files"
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
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
git config --global core.excludesfile '~/dotfiles/zsh/gitignore'

echo "-> Installing pure-prompt"
npm install --global pure-prompt

echo "-> Installing diff2html"
npm install --global diff2html-cli

echo "-> installing tmux"
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Done!"
