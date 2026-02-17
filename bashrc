# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi
# Detect platform
platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
	platform='macos'
fi

# PS1 set in prompt.sh
source $HOME/dotfiles/prompt.sh


# History and shell settings
HISTCONTROL=ignoredups:erasedups
shopt -s histappend histreedit histverify cdspell
set -o vi

# Environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export TERM="screen-256color"
export EDITOR='nvim'
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!dist/*" --glob "!node_modules/*"'
export FZF_DEFAULT_OPTS='--height 80% --border'
export HISTSIZE=1000
export PYENV_VIRTUALENV_VERBOSE_ACTIVATE=true
export PYTHONBREAKPOINT="ipdb.set_trace"

# Paths
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$GOBIN:$HOME/bin:$PATH"
PATH="$HOME/.pnpm_global:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
PATH="/opt/homebrew/opt/php@7.4/bin:/opt/homebrew/opt/php@7.4/sbin:$PATH"
PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
PATH="/opt/homebrew/Cellar/mysql@8.4/8.4.3_2/bin":$PATH
export PATH

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
# Load pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Node.js via nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash completion
nvm use default

# Direnv
if command -v direnv >/dev/null; then
	eval "$(direnv hook bash)"
fi

# Platform-specific configurations
if [[ $platform == 'linux' ]]; then
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	export GOOS=linux
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
elif [[ $platform == 'macos' ]]; then
	alias ls='ls -GFh'
	alias brew='arch -arm64 brew'
	export GOOS=darwin
	export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib -L/opt/homebrew/opt/php@7.4/lib"
	export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include -I/opt/homebrew/opt/php@7.4/include"
	export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"
fi

# Aliases
alias tmux='tmux -2'
alias weather='curl wttr.in/nashville'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias xconfig='cd $XDG_CONFIG_HOME'
alias vim=nvim
alias cleangit='git branch | grep -vE "(^\*|master|develop|main)" | xargs git branch -d'
alias localmysql='mysqld --mysql-native-password=ON'
alias harlequin='PYENV_VERSION=3.9.6 pyenv exec harlequin'

# Source other configuration files
[ -f ~/.secrets.sh ] && . ~/.secrets.sh
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

alias peek="AWS_PROFILE=peek-dev npx @peek-tech/peek-cli"
alias peek-env="npx @peek-tech/peek-cli get-env --prefix /apps/consumer/backend/"
alias peek-sso="aws sso login --sso-session peek"
