#!/bin/bash
# Create-clone-all 

## Run this script on the OLD computer in the git folder 
## It generates a script called `clone-all.sh`
## Run that `clone-all.sh` on the NEW computer in the git folder 
## Source: https://dev.to/douglaslise/how-to-migrate-all-your-git-repositores-to-a-new-computer-2c72

dirs=$(find . -name '.git' -type d | sed 's/\/\.git//')

for dir in $dirs; do
  GIT_DIR=$dir/.git

  # Creates the folder structure
  echo mkdir -p $dir;

  # Clones the repository in the same folder
  echo git clone $(git --git-dir=$GIT_DIR remote get-url origin) $dir;

  # Re-adds other remotes
  for r in $(git --git-dir=$GIT_DIR remote | grep -v origin); do
    echo git --git-dir=$GIT_DIR remote add $r $(git --git-dir=$GIT_DIR remote get-url $r);
  done

  echo
done > clone-all.sh