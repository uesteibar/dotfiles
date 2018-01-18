#! /bin/sh

echo "-> Linking vim config files"
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
echo "Done"

echo "-> Installing Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
echo "Done"

echo "-> Installing Plugins"
vim +PluginInstall +qall
echo "Done"

echo "-> Installing YouCompleteMe"
cd vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py
echo "Done"

