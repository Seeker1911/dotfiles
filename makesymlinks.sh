#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
    export XDG_CONFIG_HOME=$HOME/.config
fi
########## Variables

bindir=$HOME/bin                      # bin directory
dir=$HOME/dotfiles                    # dotfiles directory
olddir=$HOME/.dotfiles_old             # old dotfiles backup directory
configdir=$XDG_CONFIG_HOME               # config directory
nvimdir=$XDG_CONFIG_HOME/nvim            # nvim directory
ruffdir=$XDG_CONFIG_HOME/ruff
pnpmdir=$XDG_CONFIG_HOME/pnpm
luadir=$nvimdir/lua
alacrittydir=$XDG_CONFIG_HOME/alacritty

homeFiles="bashrc bash_profile vimrc tmux.conf gitignore_global gitconfig background myclirc"
configFiles="pylintrc"

##########

# create dotfiles_old in homedir
echo  "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p $olddir
mkdir -p $bindir
mkdir -p $configdir
mkdir -p $nvimdir
mkdir -p $luadir
mkdir -p $ruffdir
mkdir -p $pnpmdir

echo "Changing to the $dir directory ..."
cd $dir

echo "Moving any existing dotfiles from $HOME to $olddir"
for file in $homeFiles; do
    mv ~/.$file $olddir 2>/dev/null;
    ln -sf $dir/$file ~/.$file
done

for file in $configFiles; do
    mv $XDG_CONFIG_HOME/$file $olddir 2>/dev/null;
    ln -sf $dir/config/$file $configdir/$file
done

# mv ~/bin/ $olddir 2>/dev/null;
ln -sf $dir/bin/* $bindir/

ln -sf $dir/init.lua $nvimdir
ln -sf $dir/config/ftplugin/* $nvimdir/ftplugin/*
ln -sf $dir/lua/* $luadir
ln -sf $dir/vimrc ~/.vimrc
ln -sf $dir/config/ruff/pyproject.toml $ruffdir
ln -sf $dir/config/pnpm/rc $pnpmdir
# hardlink alacritty files
ln -f $dir/profiles/alacritty.toml $alacrittydir/alacritty.toml
ln -f $dir/profiles/alacritty_background.toml $HOME/.alacritty_background.toml
