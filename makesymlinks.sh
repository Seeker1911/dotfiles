#!/bin/bash

# Directories for dotfiles and backups
dotfiles_dir="$HOME/dotfiles"
backup_dir="$HOME/.dotfiles_old"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
nvim_dir="$config_dir/nvim"
nvim_lua_dir="$dotfiles_dir/nvim/lua"

# Files and directories to symlink
files_to_link="bashrc bash_profile vimrc tmux.conf gitignore_global gitconfig myclirc"
config_files="pylintrc"
# nvim_files="init.lua"

# Ensure backup directory exists
mkdir -p "$backup_dir" "$config_dir" "$nvim_dir"

echo "Backing up existing dotfiles and creating symlinks..."

# Move existing dotfiles to the backup directory and create symlinks
for file in $files_to_link; do
	if [[ -e "$HOME/.$file" || -L "$HOME/.$file" ]]; then
		mv "$HOME/.$file" "$backup_dir/" 2>/dev/null
	fi
	ln -sf "$dotfiles_dir/$file" "$HOME/.$file"
done

# Handle config files in $XDG_CONFIG_HOME
for file in $config_files; do
	if [[ -e "$config_dir/$file" || -L "$config_dir/$file" ]]; then
		mv "$config_dir/$file" "$backup_dir/" 2>/dev/null
	fi
	ln -sf "$dotfiles_dir/config/$file" "$config_dir/$file"
done

# Handle Neovim directory (including lua subdirectory)
if [[ -d "$nvim_dir" || -L "$nvim_dir" ]]; then
	mv "$nvim_dir" "$backup_dir/" 2>/dev/null
fi
ln -sf "$dotfiles_dir/nvim" "$nvim_dir"

# Handle Neovim individual files
# for file in $nvim_files; do
# 	if [[ -e "$nvim_dir/$file" || -L "$nvim_dir/$file" ]]; then
# 		mv "$nvim_dir/$file" "$backup_dir/" 2>/dev/null
# 	fi
# 	ln -sf "$dotfiles_dir/nvim/$file" "$nvim_dir/$file"
# done

echo "Dotfiles successfully linked!"
