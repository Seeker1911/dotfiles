#!/bin/bash
# DEPRECATED: in favor of Go setup script. (unless you just want symlinks)
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

bindir=~/bin                      # bin directory
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
configdir=~/.config               # config directory
nvimdir=~/.config/nvim            # nvim directory
alacrittydir=~/.config/alacritty            # nvim directory

homeFiles="bashrc vim viminfo tmux.conf ctags gitignore_global gitconfig Xresources"    # list of files/folders to symlink in homedir
configFiles="pycodestyle flake8 pylintrc"
nvimFiles="vimrc"
binFiles="rdrdev.sh gitlog.sh cht.sh git-ignore.sh"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
mkdir -p $bindir
mkdir -p $configdir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $homeFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done

for file in $configFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.config/$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $configdir/$file
done

for file in $binFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/bin/$file ~$olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $bindir/$file
done

# link to init.vim in  favor of nvim
ln -s $dir/.vimrc $nvimdir/init.vim
# link alaccritty config
ln -s $dir/alacritty.yml $alacrittydir/alacritty.yml
