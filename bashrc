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

# ENVIRONMENT VARIABLES -----------------------------------------------------------------------------------
export NVIM_LOG_FILE='~/.local/share/nvim/log'
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1
# Set colors to match iTerm2 Terminal Colors
export TERM="screen-256color"
export SHELL='/bin/sh'
export EDITOR='vim'
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
if [[ $platform == 'linux' ]]; then
  export GOOS=linux
  # colored GCC warnings and errors
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
  export CLOUD_SDK_REPO=cloud-sdk-jessie
elif [[ $platform == 'macos' ]]; then
  export GOOS=darwin
fi
export FZF_DEFAULT_OPTS='--height 40% --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
export HISTSIZE=5000
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYENV_VIRTUALENV_VERBOSE_ACTIVATE=true
export CHTSH_QUERY_OPTIONS="style=native"
#export CLOUDSDK_PYTHON=/Users/meadm1/google-cloud-sdk/venv/bin/python

# fix tmux panes history
# append to history file instead of overwrite on exit.
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s cdspell

export PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"
export W3MIMGDISPLAY_PATH='usr/local/bin/w3m'

# start TMUX by default if it exists. If not running interactively, do not do anything
if [[ $platform == 'linux' ]]; then
  if command -v tmux &> /dev/null;then 
    [[ $- != *i* ]] && return
    [[ -z "$TMUX" ]] && exec tmux -2
  fi
fi

# set shell to vi keybindings.
set -o vi
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
# alias vim='~/.config/nvim/nvim-osx64/bin/nvim'
# if [[ $platform == 'linux' ]]; then
#   alias vim='/usr/bin/nvim'
# elif [[ $platform == 'macos' ]]; then
#   alias vim='nvim'
# fi
CUSTOM_NVIM_PATH="~/bin/nvim.appimage"
if [[ $platform == 'linux' ]]; then
  # alias vim='~/.config/nvim/nvim.appimage'
  alias vim=$CUSTOM_NVIM_PATH
elif [[ $platform == 'macos' ]]; then
  alias vim='nvim'
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias pybug="python -m pdb -c continue"

function gitpr {
    if [ "$#" -ne 1 ]; then
	echo "Requires commit message"
	return 1;
    fi
    git pull-request -po -b devel -r robabram,wangy70,j-kanuch -m "$1"
  }

alias listen="netstat -nap tcp | grep -i 'listen'"
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

elif [[ $platform == 'macos' ]]; then
  alias ls='ls -GFh'
  alias ll='ls -l' # display long format directory
  alias l.='ls -d .*' #display all dir/ entries that begin with a '.'
  alias lc='ls -c' #List in column mode.
  alias lS='ls -S' #List by size.
  alias lt='ls -ltr' #List by time and date.
  alias icloud='cd /Library/Mobile Documents/com~apple~CloudDocs'
  if [ -d "/Applications/Firefox Developer Edition.app" ]; then
      alias fire='open -a "/Applications/Firefox Developer Edition.app" $1'
  fi
fi
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
alias exa='exa --long --header --grid' #Better listing of files. -a for dotfiles, -G for grid
alias cheat='cht.sh --shell'
alias welcome='cowsay -f tux "welcome Programs, now begins your real training" | lolcat'
alias cdg='cd `git rev-parse --show-toplevel`'  # cd to the "home" of a git repo

# SOURCE OTHER FILES ---------------------------------------------------------------------------------------
[ -f ~/.secrets/secrets.sh ] && source ~/.secrets/secrets.sh
[ -f ~/.bin/tmuxinator.bash ] && source ~/.bin/tmuxinator.bash
#fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Things I've used to fix mysql and GAE stuff for historical record.
LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
# when getting compiler errors running the below command allowed it to install regardless of having the above LDFLAGS already set.
# env LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib" pip --no-cache install psycopg2


# UPDATE PATH FOR THE GOOGLE CLOUD SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi

# ENABLES SHELL COMMAND COMPLETION FOR GCLOUD.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi
if [ ! -L /usr/local/opt/mysql/lib/libmysqlclient.20.dylib ] && [ -f '/usr/local/opt/mysql/lib/libmysqlclient.20.dylib' ]; then
	ln -s /usr/local/opt/mysql@5.7/lib/libmysqlclient.20.dylib /usr/local/opt/mysql/lib/libmysqlclient.20.dylib 
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# PATH -------------------------------------------------------------------------------------------------------
PATH="${PATH}:/usr/local"
PATH="${PATH}:/usr/local/go/bin"
PATH="${PATH}:/usr/local/bin"
PATH="${PATH}:/usr/local/sbin"
PATH="${PATH}:/usr/local/liquibase-4.0.0-beta1"
PATH="${PATH}:${HOME}/go/bin"
# SET A HOME/BIN PATH FOR SHELL SCRIPTS
PATH="$HOME/bin:$PATH"

if [[ $platform == 'linux' ]]; then
  #export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  #export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
  #export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
  #export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
  export PATH="$HOME/.pyenv/bin:$PATH"
fi

# PATH="/usr/local/opt/gettext/bin:$PATH"
 PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# PATH=$PATH:/usr/local/opt/rabbitmq/sbin
# PYENV_ROOT="usr/local/bin/pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [[ $platform == 'macos' ]]; then
  # Fix for:
  #bash: __bp_precmd_invoke_cmd: command not found
  #bash: __bp_interactive_mode: command not found
  CFLAGS="-I$(brew --prefix openssl)/include"
  LDFLAGS="-L$(brew --prefix openssl)/lib" 
  unset PROMPT_COMMAND
fi

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

function testy {
  python -m unittest discover -s tests -f -p *$@*
}

function sith {
  if [[ $platform == 'macos' ]]; then
            echo -ne "\033]50;SetProfile=gruvbox dark\a"
            export ITERM_PROFILE="gruvbox dark"
	    export PS1="\[\033[32m\]seeker \[\033[38;5;172m\]\[\033[38;5;172m\]\w\[\033[m\]\$ "
	    [ -n "$PS1" ] && sh ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh
	    tmux source ~/dotfiles/tmux.conf
  fi
}

function jedi {
  if [[ $platform == 'macos' ]]; then
            echo -ne "\033]50;SetProfile=gruvbox light\a"
            export ITERM_PROFILE="gruvbox light"
	    tmux source ~/dotfiles/tmux_light.conf
  fi
}

function snow {
  if [[ $platform == 'macos' ]]; then
          echo -ne "\033]50;SetProfile=snow light\a"
          export ITERM_PROFILE="snow light"
	  export PS1="\[\033[32m\]seeker \[\033[38;5;172m\]\[\033[38;5;172m\]\w\[\033[m\]\$ "
	  [ -n "$PS1" ] && sh ~/.config/nvim/plugged/snow/shell/snow_light.sh
	  tmux source ~/dotfiles/tmux_light.conf
  fi
}

function night {
  if [[ $platform == 'macos' ]]; then
          echo -ne "\033]50;SetProfile=snow night\a"
          export ITERM_PROFILE="snow night"
	  export PS1="\[\033[32m\]seeker \[\033[38;5;172m\]\[\033[38;5;172m\]\w\[\033[m\]\$ "
	  [ -n "$PS1" ] && sh ~/.config/nvim/plugged/snow/shell/snow_dark.sh
	  tmux source ~/dotfiles/tmux.conf
  fi
}

# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)

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
# register python argcomplete for airflow
complete -o nospace -o default -o bashdefault -F _python_argcomplete airflow
set completion-ignore-case on
set show-all-if-ambiguous on

eval "$(starship init bash)"
