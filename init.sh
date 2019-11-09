#!/bin/bash

pretty_print() {
  printf "\n%b\n" "................ $1 ................ "
}
pretty_print "Here we go..."

# Homebrew installation
if ! command -v brew &>/dev/null; then
  pretty_print "Installing Homebrew, an OSX package manager, follow the instructions..." 
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  pretty_print "Homebrew already installed."
fi

## ZSH setup / installation
# Archive old zsh 
pretty_print "archiving old zsh dotfiles..."
rm -rf ~/.zshrc.old
rm -rf ~/.oh-my-zsh.old
mv ~/.zshrc ~/.zshrc.old
mv ~/.oh-my-zsh ~/.oh-my-zsh.old

# Install zsh + oh-my-zsh
pretty_print "Installing zsh"
brew install zsh  

pretty_print "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

pretty_print "Installing powerlevel10k theme" 

# source this repo zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
printf "source `pwd`/zshrc.txt" > ~/.zshrc

# backup old stuff
rm -rf ~/.vim.old
rm ~/.vimrc.old
mv ~/.vimrc ~/.vimrc.old
mv ~/.vim ~/.vim.old
# Plugins 
PLUG="curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo `$PLUG`

printf "source `pwd`/vimrc.txt" > ~/.vimrc
