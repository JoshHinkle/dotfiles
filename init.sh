#!/bin/bash
# backup old stuff
rm -rf ~/.vim.old
mv ~/.vimrc ~/.vimrc.old
mv ~/.vim ~/.vim.old
# Plugins 
PLUG="curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo `$PLUG`

printf "source `pwd`/vimrc.txt" > ~/.vimrc
