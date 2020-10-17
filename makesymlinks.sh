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
vimfiledir=~/dotfiles/vim

homeFiles="bashrc bash_profile vim vimrc viminfo tmux.conf gitignore_global gitconfig Xresources ideavimrc git_template"    # list of files/folders to symlink in homedir
configFiles="pycodestyle flake8 pylintrc starship.toml"
vimFiles="autoload/plug.vim"
binFiles="rdrdev.sh gitlog.sh cht.sh git-ignore.sh slack.sh"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
mkdir -p $bindir
mkdir -p $configdir
mkdir -p $nvimdir
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
    ln -sf $dir/$file ~/.$file
done

for file in $configFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.config/$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -sf $dir/linters/$file $configdir/$file
done

for file in $binFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/bin/$file ~$olddir
    echo "Creating symlink to $file in home directory."
    ln -sf $dir/utils/$file $bindir/$file
done

for file in $vimFiles; do
    mkdir -p ~/vim/autoload
    ln -sf $vimfiledir/$file ~/vim/autoload/$file
done

# link to init.vim in  favor of nvim
ln -sf $dir/vimrc $nvimdir/init.vim
#ln -sf $dir/vimrc ~/.vimrc
# link alaccritty config
ln -sf $dir/profiles/alacritty.yml $alacrittydir/alacritty.yml
