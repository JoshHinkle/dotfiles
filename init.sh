!/bin/bash

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
brew install python

# Apps
brew install --cask intellij-idea
brew install --cask iterm2
brew install --cask insomnia
brew install --cask datagrip
brew install --cask alfred
brew install --cask visual-studio-code
brew install --cask docker

pretty_print "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

pretty_print "Installing powerlevel10k theme" 

# source this repo zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
printf "source `pwd`/zshrc.txt\n" > ~/.zshrc

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
git config --global push.default current
git config --global pull.rebase false
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
ln -s -f /usr/local/bin/python3 /usr/local/bin/python
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
echo "use dummy for these AWS Access Key ID [None]: dummy
AWS Secret Access Key [None]: dummy
Default region name [None]: us-west-1
Default output format [None]:"
aws configure
rm -rf awscli-bundle
rm awscli-bundle.zip

brew tap AdoptOpenJDK/openjdk
brew install --cask aAdoptOpenJDK/openjdk/adoptopenjdk
brew install --cask adoptopenjdk8
brew install --cask adoptopenjdk11
brew install --cask adoptopenjdk13
brew install --cask adoptopenjdk15

# Change screenshots
mkdir ~/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
