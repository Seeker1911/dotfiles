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
export LANG=en_US.UTF-8
# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1
# Set colors to match iTerm2 Terminal Colors
export TERM="screen-256color"
export SHELL='/bin/sh'
export EDITOR='nvim'
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export FZF_DEFAULT_OPTS='--height 50% --border'
export FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case --glob '!{.git, build}'"
export HISTSIZE=1000
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYENV_VIRTUALENV_VERBOSE_ACTIVATE=true
export CHTSH_QUERY_OPTIONS="style=native"
# export PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"
export W3MIMGDISPLAY_PATH='usr/local/bin/w3m'
export REVIEW_BASE=HEAD^ # used with git alias in gitconfig
export PIPENV_IGNORE_VIRTUALENVS=1
export DOCKER_DEFAULT_PLATFORM=linux/amd64

if [ -x "$(command -v ipdb)" ]; then
    export PYTHONBREAKPOINT="ipdb.set_trace"
fi

# (updated .bashrc)

# Utility for removing an entry from $PATH -- copied from SO post:
# https://stackoverflow.com/questions/11650840/remove-redundant-paths-from-path-variable#answer-47159781
pathremove() {
    local IFS=':'
    local NEWPATH
    local DIR
    local PATHVARIABLE=${2:-PATH}
    for DIR in ${!PATHVARIABLE} ; do
        if [ "$DIR" != "$1" ] ; then
            NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
        fi
    done
    export $PATHVARIABLE="$NEWPATH"
}

export NVM_DIR="$HOME/.nvm"
DEFAULT_NODE_VERSION="v12.10.0"
load_nvm() {
    # TODO: ionice -c 1 -n 0 nice -n -20 cmd... ?
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
# load_nvm

# This gets node & friends into the path but doesn't initialize nvm proper until needed
lasy_load_nvm() {
    export NVM_BIN="$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin"
    export PATH="$NVM_BIN:$PATH"
    export NVM_CD_FLAGS=""
    alias nvm="echo 'Please wait while nvm loads' && unset NVM_CD_FLAGS && pathremove $NVM_BIN && unset NVM_BIN && unalias nvm && load_nvm && nvm $@"
}
lasy_load_nvm

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
  alias brew='arch -arm64 brew'
  export GOOS=darwin
  if [ -d "/Applications/Firefox Developer Edition.app" ]; then
      alias fire='open -a "/Applications/Firefox Developer Edition.app" $1'
  fi
    # Fix for:
    #bash: __bp_precmd_invoke_cmd: command not found
    #bash: __bp_interactive_mode: command not found
    # CFLAGS="-I$(brew /opt/homebrew/Cellar/openssl)/include"
    # CFLAGS="-I /opt/homebrew/Cellar/openssl@3/3.0.5/include"
    # LDFLAGS="-L$(brew /opt/homebrew openssl)/lib" 
    #LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
    # LDFLAGS="-L$(brew --prefix openssl)/lib"
    # CFLAGS="-I$(brew --prefix openssl)/include"
    # my attempt as getting rosetta to work
    # export LDFLAGS="-L$(brew /opt/homebrew/Cellar/zlib)/lib -L$(brew /opt/homebrew/Cellar/gbzip2)/lib"
    # CPPFLAGS="-I/opt/homebrew/include" 
    # LDFLAGS="-L/opt/homebrew/lib" 
    # echo "++++++++++++++++++++++++++++++++++++++++"
    # echo $LDFLAGS
    # echo "++++++++++++++++++++++++++++++++++++++++"
    # export CPPFLAGS="-I$(brew /opt/homebrew/Cellar/zlib)/include -I$(brew /opt/homebrew/Cellar/gbzip2)/include"
    # export CPATH=/opt/homebrew/include
    # export LIBRARY_PATH=/opt/homebrew/lib
    # CPPFLAGS="-I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" LDFLAGS="-L$(brew --prefix openssl)/lib"
    # export LDFLAGS="-L/opt/homebrew/lib"; export CPPFLAGS="-I/opt/homebrew/include"

    # echo "++++++++++++++++++++++++++++++++++++++++"
    # echo $LDFLAGS
    # echo $CPPFLAGS
    # echo "++++++++++++++++++++++++++++++++++++++++"

    # unset PROMPT_COMMAND
fi

# alias vim='nvim'
alias tmux='tmux -2'
alias play='ls /usr/share/emacs/22.1/lisp/play' 
alias weather='curl wttr.in/nashville'
alias starwars='telnet towel.blinkenlights.nl'
alias grep='grep --color'
alias ipe='curl ipinfo.io/ip' #Get external ip address
# https://the.exa.website/docs/command-line-options
alias exa='exa --long --header --grid' #Better listing of files. -a for dotfiles, -G for grid
# alias exa='exa --icons' #Better listing of files. -a for dotfiles, -G for grid
alias cheat='cht.sh --shell'
alias welcome='cowsay -f tux "welcome Programs, now begins your real training" | lolcat'
alias cleangit='git branch | grep -v "master" | grep -v "develop" | grep -v "main" | xargs git branch -D'
alias cdg='cd `git rev-parse --show-toplevel`'  # cd to the "home" of a git repo

# SOURCE OTHER FILES ---------------------------------------------------------------------------------------
[ -f ~/.secrets/secrets.sh ] && source ~/.secrets/secrets.sh
[ -f ~/.profile ] && source ~/.profile

#fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# NOTE: completions really slow down sourcing the shell.
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
#fi

# PATH -------------------------------------------------------------------------------------------------------
PATH="/opt/homebrew/bin:${PATH}"
# PATH="${PATH}:/usr/local/go/bin"
PATH="${PATH}:${HOME}/go/bin"
# PATH="${PATH}:/usr/local/sbin"
PATH="${PATH}:${HOME}/.npm"
PATH="${PATH}:${HOME}/.node-gyp"
# PATH="${PATH}:/usr/local/Cellar/postgresql/13.0/bin"
PATH="$HOME/.pyenv/bin:$PATH"
PATH="$HOME/.pyenv/shims:$PATH"
PATH="$HOME/bin:$PATH"
# PATH="$HOME/bin/nvim-osx64/bin:$PATH"
# If you need to have openssl@1.1 first in your PATH:
# NOTE: seeing if I really need this
# PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH

# export PGDATA="/usr/local/Cellar/postgresql/13.0/bin/psql"

# For pkg-config to find openssl@1.1 you may need to set:
#export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
# This magically fixes psycopg2 install error madness, the above did not.
#export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"
export XDG_CONFIG_HOME="$HOME/.config"

# pyenv ----------------------------------------------------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


function nvimvenv {
  if [[ -e "$VIRTUAL_ENV" && -f "$VIRTUAL_ENV/bin/activate" ]]; then
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi
    source "$VIRTUAL_ENV/bin/activate"
    command nvim $@
    deactivate
  else
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi
    command nvim $@
  fi
}

alias vim=nvimvenv

# if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
#   source "${VIRTUAL_ENV}/bin/activate"
# fi


# functions ----------------------------------------------------------------------------------------------------
function jedi {
    echo "color gruvbox" > ~/.background
    echo "set background=light" >> ~/.background
    tmux source ${HOME}/dotfiles/colors/tmux-gruvbox-light.conf
    # alacritty-colorscheme apply gruvbox_light.yaml
}

function sith {
    echo "color gruvbox" > ~/.background
    echo "set background=dark" >> ~/.background
    echo "let g:airline_theme='snow_dark'" >> ~/.background
    tmux source ${HOME}/dotfiles/tmux.conf
    # alacritty-colorscheme apply gruvbox_dark.yaml
}

function burnt_toast {
    echo "color toast" > ~/.background
    echo "set background=dark" >> ~/.background
    tmux source ${HOME}/dotfiles/tmux.conf
}

function solar {
    echo "color two-firewatch" > ~/.background
    echo "set background=light" >> ~/.background
    # alacritty-colorscheme apply solarized_light.yaml
}

function kindle {
    echo "color leaf" > ~/.background
    echo "set background=light" >> ~/.background
    tmux source ${HOME}/dotfiles/colors/tmux_kindle.conf
    # alacritty-colorscheme apply pencil_light.yaml
}

function fox {
    echo "color dayfox" > ~/.background
    echo "set background=light" >> ~/.background
    tmux source ${HOME}/dotfiles/colors/tmux_kindle.conf
    # alacritty-colorscheme apply pencil_light.yaml
}

function toast {
    echo "color toast" > ~/.background
    echo "set background=light" >> ~/.background
    tmux source ${HOME}/dotfiles/colors/tmux_toast.conf
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
if [ -x "$(command -v direnv)" ]; then
	eval "$(direnv hook bash)"
fi
