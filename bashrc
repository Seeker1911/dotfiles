platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
fi

# for dark background
if [[ $platform == 'linux' ]]; then
    # gruvbox ps1
    export PS1="\[\033[32m\]seeker-remote\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
    [ -n "$PS1" ] && sh ~/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh
elif [[ $platform == 'macos' ]]; then
    # gruvbox ps1
    export PS1="\[\033[32m\]seeker \[\033[38;5;172m\]\[\033[38;5;172m\]\w\[\033[m\]\$ "
    [ -n "$PS1" ] && sh ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh

fi


# fix tmux panes history
# append to history file instead of overwrite on exit.
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s cdspell

# set shell to vi keybindings.
set -o vi
set completion-ignore-case on
set show-all-if-ambiguous on


# ENVIRONMENT VARIABLES -----------------------------------------------------------------------------------
export XDG_CONFIG_HOME=~/.config
export BASH_SILENCE_DEPRECATION_WARNING=1
export MYVIMRC=~/dotfiles/vimrc
export NVIM_LOG_FILE=~/.local/share/nvim/log
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1
# Set colors to match iTerm2 Terminal Colors
export TERM="screen-256color"
export SHELL='/bin/sh'
export EDITOR='vim'
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export FZF_DEFAULT_OPTS='--height 50% --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
export HISTSIZE=5000
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYENV_VIRTUALENV_VERBOSE_ACTIVATE=true
export CHTSH_QUERY_OPTIONS="style=native"
export PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"
export W3MIMGDISPLAY_PATH='usr/local/bin/w3m'
export REVIEW_BASE=HEAD^ # used with git alias in gitconfig
export PIPENV_IGNORE_VIRTUALENVS=1

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ $platform == 'linux' ]]; then
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi
  export GOOS=linux
  # colored GCC warnings and errors
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
  export CLOUD_SDK_REPO=cloud-sdk-jessie
elif [[ $platform == 'macos' ]]; then
  alias ls='ls -GFh'
  alias ll='ls -l' # display long format directory
  alias l.='ls -d .*' #display all dir/ entries that begin with a '.'
  alias lc='ls -c' #List in column mode.
  alias lS='ls -S' #List by size.
  alias lt='ls -ltr' #List by time and date.
  export GOOS=darwin
  if [ -d "/Applications/Firefox Developer Edition.app" ]; then
      alias fire='open -a "/Applications/Firefox Developer Edition.app" $1'
  fi
    # Fix for:
    #bash: __bp_precmd_invoke_cmd: command not found
    #bash: __bp_interactive_mode: command not found
    # CFLAGS="-I$(brew --prefix openssl)/include"
    # LDFLAGS="-L$(brew --prefix openssl)/lib" 
    # LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
    # my attempt as getting rosetta to work
    export LDFLAGS="-L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib"
    export CPPFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix bzip2)/include"

    unset PROMPT_COMMAND
fi

alias vim='nvim'
alias listen="netstat -nap tcp | grep -i 'listen'"
alias pybug="python -m pdb -c continue"
alias tmux='tmux -2'
alias dunnet='emacs -batch -l dunnet'
alias play='ls /usr/share/emacs/22.1/lisp/play' 
alias weather='curl wttr.in/nashville'
alias starwars='telnet towel.blinkenlights.nl'
alias raspberry="ssh pi@10.0.0.135"
alias sha='shasum -a 256 ' #Test the checksum of a file.
alias grep='grep --color'
alias ping='ping -c 5' #Limit ping to 5 attempts.
alias www="python -m simpleHTTPServer 8000"
alias speedtest='speedtest-cli --server 2406 --simple' #run speed test.
alias ipe='curl ipinfo.io/ip' #Get external ip address
# https://the.exa.website/docs/command-line-options
# alias exa='exa --long --header --grid' #Better listing of files. -a for dotfiles, -G for grid
# alias exa='exa --icons' #Better listing of files. -a for dotfiles, -G for grid
alias cheat='cht.sh --shell'
alias welcome='cowsay -f tux "welcome Programs, now begins your real training" | lolcat'
alias cleangit='git branch | grep -v "master" | grep -v "dev" | xargs git branch -D'

alias cdg='cd `git rev-parse --show-toplevel`'  # cd to the "home" of a git repo

# SOURCE OTHER FILES ---------------------------------------------------------------------------------------
[ -f ~/.secrets/secrets.sh ] && source ~/.secrets/secrets.sh
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.bin/tmuxinator.bash ] && source ~/.bin/tmuxinator.bash

#fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# PATH -------------------------------------------------------------------------------------------------------
# PATH="/usr/local/bin:${PATH}"
PATH="/opt/homebrew/bin:${PATH}"
# PATH="${PATH}:/usr/local"
PATH="${PATH}:/usr/local/go/bin"
PATH="${PATH}:/usr/local/sbin"
PATH="${PATH}:/usr/local/liquibase-4.0.0-beta1"
PATH="${PATH}:${HOME}/go/bin"
PATH="${PATH}:${HOME}/.npm"
PATH="${PATH}:${HOME}/.node-gyp"
PATH="${PATH}:/usr/local/Cellar/postgresql/13.0/bin"
PATH="/opt/homebrew/opt/node@16/bin:$PATH"
PATH="$HOME/.pyenv/bin:$PATH"
PATH="$HOME/.pyenv/shims:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/bin/nvim-osx64/bin:$PATH"
# If you need to have openssl@1.1 first in your PATH:
PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH

export PGDATA="/usr/local/Cellar/postgresql/13.0/bin/psql"

# For pkg-config to find openssl@1.1 you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
# This magically fixes psycopg2 install error madness, the above did not.
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"
export XDG_CONFIG_HOME="$HOME/.config"

# pyenv ----------------------------------------------------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

if [[ -f $HOME/.cargo/env ]]; then
    source "$HOME/.cargo/env"
fi

# if [[ $platform == 'macos' ]]; then
#         source /Users/michaelmead/.config/alacritty/extra/completions/alacritty.bash
# fi

# functions ----------------------------------------------------------------------------------------------------
function jedi {
    echo "color gruvbox" > ~/.vim_background
    echo "set background=light" >> ~/.vim_background
    tmux source ${HOME}/dotfiles/colors/tmux-gruvbox-light.conf
    # alacritty-colorscheme apply gruvbox_light.yaml
}

function sith {
    echo "color gruvbox" > ~/.vim_background
    echo "set background=dark" >> ~/.vim_background
    echo "let g:airline_theme='snow_dark'" >> ~/.vim_background
    tmux source ${HOME}/dotfiles/tmux.conf
    # alacritty-colorscheme apply gruvbox_dark.yaml
}

function snow {
    echo "color snow" > ~/.vim_background
    echo "set background=light" >> ~/.vim_background
    echo "let g:airline_theme='snow_light'" >> ~/.vim_background
    tmux source ${HOME}/dotfiles/colors/tmux_snow.conf
}

function solar {
    echo "color two-firewatch" > ~/.vim_background
    echo "set background=light" >> ~/.vim_background
    # alacritty-colorscheme apply solarized_light.yaml
}

function kindle {
    echo "color envy" > ~/.vim_background
    echo "set background=light" >> ~/.vim_background
    tmux source ${HOME}/dotfiles/colors/tmux_kindle.conf
    # alacritty-colorscheme apply pencil_light.yaml
}

function color {
    pyenv shell neovim3 && $1 && pyenv shell --unset
}

function cleanswap {
	rm ~/.local/share/nvim/swap/*
}

# Run something, muting output or redirecting it to the debug stream
# depending on the value of _ARC_DEBUG.
__python_argcomplete_run() {
    if [[ -z "$_ARC_DEBUG" ]]; then
        "$@" 8>&1 9>&2 1>/dev/null 2>&1
    else
        "$@" 8>&1 9>&2 1>&9 2>&1
    fi
}

_python_argcomplete() {
    local IFS=$'\013'
    local SUPPRESS_SPACE=0
    if compopt +o nospace 2> /dev/null; then
        SUPPRESS_SPACE=1
    fi
    COMPREPLY=( $(IFS="$IFS" \
                  COMP_LINE="$COMP_LINE" \
                  COMP_POINT="$COMP_POINT" \
                  COMP_TYPE="$COMP_TYPE" \
                  _ARGCOMPLETE_COMP_WORDBREAKS="$COMP_WORDBREAKS" \
                  _ARGCOMPLETE=1 \
                  _ARGCOMPLETE_SUPPRESS_SPACE=$SUPPRESS_SPACE \
                  __python_argcomplete_run "$1") )
    if [[ $? != 0 ]]; then
        unset COMPREPLY
    elif [[ $SUPPRESS_SPACE == 1 ]] && [[ "$COMPREPLY" =~ [=/:]$ ]]; then
        compopt -o nospace
    fi
}

# [ -f /Users/michaelmead/.config/alacritty/extra/completions/alacritty.bash ] && source /Users/michaelmead/.config/alacritty/extra/completions/alacritty.bash
if command -v theme.sh > /dev/null; then
	[ -e ~/.theme_history ] && theme.sh "$(theme.sh -l|tail -n1)"

	# Optional  

	bind -x '"\x0f":"theme.sh $(theme.sh -l|tail -n2|head -n1)"' #Binds C-o to the previously active theme.
	alias th='theme.sh -i'

	# Interactively load a light theme
	alias thl='theme.sh --light -i'

	# Interactively load a dark theme
	alias thd='theme.sh --dark -i'
fi

complete -C '/usr/local/bin/aws_completer' aws
