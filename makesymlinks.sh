#!/bin/bash

# Directories for dotfiles and backups
dotfiles_dir="$HOME/dotfiles"
backup_dir="$HOME/.dotfiles_old"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
nvim_dir="$config_dir/nvim"
ghost_dir="$config_dir/ghostty"
nvim_lua_dir="$dotfiles_dir/nvim/lua"
claude_dir="$HOME/.claude"

# Files and directories to symlink
files_to_link="zshrc zprofile vimrc tmux.conf gitignore_global gitconfig myclirc ideavimrc"
config_files="pylintrc"
# nvim_files="init.lua"

# Ensure backup directory exists
mkdir -p "$backup_dir" "$config_dir" "$nvim_dir" "$ghost_dir" "$config_dir/opencode" "$claude_dir"

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
ln -sfn "$dotfiles_dir/nvim" "$nvim_dir"

if [[ -d "$ghost_dir" || -L "$ghost_dir" ]]; then
	mv "$ghost_dir" "$backup_dir/" 2>/dev/null
fi

# Link entire ghostty directory
ln -sfn "$dotfiles_dir/ghostty" "$ghost_dir"

# Link ruff config directory
mkdir -p "$config_dir/ruff"
ln -sf "$dotfiles_dir/config/ruff/pyproject.toml" "$config_dir/ruff/pyproject.toml"

# Link opencode AGENTS.md
ln -sf "$dotfiles_dir/agents/AGENTS.md" "$config_dir/opencode/AGENTS.md"

# Link Claude template to ~/.claude/CLAUDE.md
if [[ -e "$HOME/.claude/CLAUDE.md" || -L "$HOME/.claude/CLAUDE.md" ]]; then
	mv "$HOME/.claude/CLAUDE.md" "$backup_dir/" 2>/dev/null
fi

ln -sf "$dotfiles_dir/agents/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# Link skills directory to ~/.claude/skills
if [[ -e "$HOME/.claude/skills" || -L "$HOME/.claude/skills" ]]; then
	mv "$HOME/.claude/skills" "$backup_dir/" 2>/dev/null
fi
cp -r "$dotfiles_dir/agents/skills" "$HOME/.claude/skills"

# Link commands directory to ~/.claude/commands
if [[ -e "$HOME/.claude/commands" || -L "$HOME/.claude/commands" ]]; then
	mv "$HOME/.claude/commands" "$backup_dir/" 2>/dev/null
fi
ln -sfn "$dotfiles_dir/agents/commands" "$HOME/.claude/commands"

# Link hooks directory to ~/.claude/hooks
if [[ -e "$HOME/.claude/hooks" || -L "$HOME/.claude/hooks" ]]; then
	mv "$HOME/.claude/hooks" "$backup_dir/" 2>/dev/null
fi
ln -sfn "$dotfiles_dir/agents/hooks" "$HOME/.claude/hooks"

# Link settings.json to ~/.claude/settings.json
if [[ -e "$HOME/.claude/settings.json" || -L "$HOME/.claude/settings.json" ]]; then
	mv "$HOME/.claude/settings.json" "$backup_dir/" 2>/dev/null
fi
ln -sf "$dotfiles_dir/agents/settings.json" "$HOME/.claude/settings.json"
ln -sf "$dotfiles_dir/profiles/statusline.sh" "$HOME/.claude/statusline.sh"

# Link custom oh-my-zsh themes
omz_themes_dir="$HOME/.oh-my-zsh/custom/themes"
mkdir -p "$omz_themes_dir"
ln -sf "$dotfiles_dir/oh-my-zsh/custom/themes/mp.zsh-theme" "$omz_themes_dir/mp.zsh-theme"

echo "Dotfiles successfully linked!"
