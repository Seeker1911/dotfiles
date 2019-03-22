platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
fi

# COLOR PROMPTS ------------------------------------------------------------------------------
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # a full PS1 prompt
# if colorschemes don't overide cli, use these options.
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
# for dark background
if [[ $platform == 'linux' ]]; then
export PS1="\[\033[32m\]seeker-remote\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
elif [[ $platform == 'macos' ]]; then
#export PS1="\[\033[32m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
# gruvbox ps1
export PS1="\[\033[32m\]seeker 🔥\[\033[38;5;172m\]\[\033[38;5;172m\]\w\[\033[m\]\$ "
#snow ps1
#export PS1="\[\033[208m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
fi

# colorschemes ----------------------------------------------------------------------------------------------
# apply vimspectr theme to shell
#[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectr210-dark #load vimspectr on shell startup
#vim(){ sh -c "vim $*"; sh ~/.vimspectr-shell/vimspectr210-dark;  clear; } #restore shell theme on vim exit
# apply the dark snow theme to your shell
#[ -n "$PS1" ] && sh ~/.vim/plugged/snow/shell/snow_dark.sh # or use snow_light.sh for light theme
#[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectr30-dark
#[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectr60-dark
#[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectrgrey-dark
[ -n "$PS1" ] && sh ~/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh

# ENVIRONMENT VARIABLES -----------------------------------------------------------------------------------
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export SHELL='/bin/bash'
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
export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob "!.git/*"'
export HISTSIZE=5000
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# fix tmux panes history
# append to history file instead of overwrite on exit.
shopt -s histappend
shopt -s histreedit
shopt -s histverify

export HISTCONTROL='ingoreboth'
export PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"

# start TMUX by default if it exists. If not running interactively, do not do anything
if [[ $platform == 'linux' ]]; then
  if command -v tmux &> /dev/null;then 
    [[ $- != *i* ]] && return
    [[ -z "$TMUX" ]] && exec tmux -2
  fi
fi

# ALIASES -----------------------------------------------------------------------------------------------
# use neovim by default
# set shell to vi keybindings.
set -o vi
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
if [[ $platform == 'linux' ]]; then
  alias vim='/home/linuxbrew/.linuxbrew/bin/nvim'
elif [[ $platform == 'macos' ]]; then
  #alias vim='/usr/local/bin/vim'
  alias vim='nvim'
fi
alias pybug="python -m pdb -c continue"
#alias mysql@5.7='mysql'
# use hub as default for git https://hub.github.com/
alias git=hub
alias listen="netstat -nap tcp | grep -i 'listen'"
alias server="python -m simpleHTTPServer 8000"
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
alias rasberry="ssh pi@10.0.0.135"
alias sha='shasum -a 256 ' #Test the checksum of a file.
alias grep='grep --color'
alias ping='ping -c 5' #Limit ping to 5 attempts.
alias www='python -m SimpleHTTPServer 8000' #start python 2 webserver.
alias speedtest='speedtest-cli --server 2406 --simple' #run speed test.
alias ipe='curl ipinfo.io/ip' #Get external ip address
# https://the.exa.website/docs/command-line-options
alias exa='exa --long --header --grid' #Better listing of files. -a for dotfiles, -G for grid

# source rdr venv
alias sordr='source rdr_client/venv/bin/activate'
alias generate_data='cd rdr_client && ./run_client.sh generate_fake_data.py --num_participants 20 --include_physical_measurements --include_biobank_orders --create_biobank_samples && cd ../rest-api'

# SOURCE OTHER FILES ---------------------------------------------------------------------------------------
[ -f ~/.secrets/secrets.sh ] && source ~/.secrets/secrets.sh
[ -f ~/.bin/tmuxinator.bash ] && source ~/.bin/tmuxinator.bash
#fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Things I've used to fix mysql and GAE stuff for historical record.
#LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

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
# SET A HOME/BIN PATH FOR SHELL SCRIPTS
PATH="$HOME/bin:$PATH"

if [[ $platform == 'linux' ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
  export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
  PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

PATH="/usr/local/opt/gettext/bin:$PATH"
PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [[ $platform == 'macos' ]]; then
  # Fix for:
  #bash: __bp_precmd_invoke_cmd: command not found
  #bash: __bp_interactive_mode: command not found
  unset PROMPT_COMMAND
fi
