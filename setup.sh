#! /bin/sh

echo "-> Linking vim config files"
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim

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

echo "-> Installing pure-prompt"
npm install --global pure-prompt

echo "Done!"