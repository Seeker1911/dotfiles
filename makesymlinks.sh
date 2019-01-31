#!/bin/bash

# DEPRECATED: in favor of Go setup script.
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
homeFiles="bashrc vim viminfo tmux.conf ctags gitignore_global Xresources"    # list of files/folders to symlink in homedir
configFiles="pycodestyle flake8"
nvimFiles="vimrc"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $homeFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done

for file in $configFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.config/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.config/$file
done

# link to init.vim in  favor of nvim
ln -s $dir/.vimrc ~/.config/nvim/init.vim
