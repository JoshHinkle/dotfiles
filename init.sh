!/bin/bash

pretty_print() {
  printf "\n%b\n" "................ $1 ................ "
}
pretty_print "Here we go..."

# Homebrew installation
if ! command -v brew &>/dev/null; then
  pretty_print "Installing Homebrew, an OSX package manager, follow the instructions..." 
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# Install zsh
pretty_print "Installing zsh"
brew install zsh  
brew install python3


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

# Apps
brew install --cask intellij-idea
brew install --cask iterm2
brew install --cask insomnia
brew install --cask datagrip
brew install --cask alfred
brew install --cask visual-studio-code
brew install --cask docker

# Vim Plugins 
PLUG="curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo `$PLUG`
brew install fzf
$(brew --prefix)/opt/fzf/install


# Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

printf "source `pwd`/vimrc.txt" > ~/.vimrc
git config --global push.default current
git config --global pull.rebase false
#curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
#unzip awscli-bundle.zip
sudo ln -s -f /usr/local/bin/python3 /usr/local/bin/python
#sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
which aws
aws --version

# Install JAVA Versions
brew install openjdk@11
brew install openjdk@17
brew install openjdk@21

sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk


# Change screenshots
mkdir ~/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots

# Put brew on path
eval "$(/opt/homebrew/bin/brew shellenv)"