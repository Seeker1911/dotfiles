#!/bin/bash
set -euo pipefail

if brew list --formula mysql &>/dev/null; then
	brew pin mysql
	echo "Plain mysql is installed: $(brew list --versions mysql). It is pinned now."
	echo "Unlink or uninstall it so mysql@9.7 can link."
fi

brew bundle install --file="$HOME/dotfiles/Brewfile"
