platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
fi

#example
#if [[ $platform == 'linux' ]]; then
#alias ls='ls --color=auto'
#elif [[ $platform == 'macos' ]]; then
#alias ls='ls -G'
#fi
# Command Line color prompts ------------------------------------------------------------------------------
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # a full PS1 prompt
# if colorschemes don't overide cli, use these options.
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
# for dark background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export PS1="\[\033[32m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
export SHELL='/bin/bash'
export EDITOR='vim'
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
if [[ $platform == 'linux' ]]; then
  export GOOS=linux
elif [[ $platform == 'macos' ]]; then
  export GOOS=mac
fi
export FZF_DEFAULT_OPTS='--height 40% --border'
export HISTSIZE=5000
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# fix tmux panes history
shopt -s histappend
shopt -s histreedit
shopt -s histverify

HISTCONTROL='ingoreboth'
PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"

# start TMUX by default if it exists. If not running interactively, do not do anything
#if command -v tmux &> /dev/null;then 
#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux -2
#fi
# aliases -----------------------------------------------------------------------------------------------
# set to vi keybindings.
set -o vi
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
if [[ $platform == 'linux' ]]; then
  alias vim='/home/linuxbrew/.linuxbrew/bin/vim'
elif [[ $platform == 'macos' ]]; then
  alias vim='/usr/local/bin/vim'
fi
alias mysql@5.7='mysql'
# use hub as default for git https://hub.github.com/
alias git=hub
alias listen="netstat -nap tcp | grep -i 'listen'"
alias python='python'
alias server="python -m simpleHTTPServer 8000"
if [[ $platform == 'linux' ]]; then
alias ls='ls --color=auto'
elif [[ $platform == 'macos' ]]; then
alias ls='ls -GFh'
fi
alias tmux='tmux -2'
alias scratch='vim ~/Documents/Programming/scratchpad.sh'
alias dunnet='emacs -batch -l dunnet'
alias play='ls /usr/share/emacs/22.1/lisp/play' 
alias weather='curl wttr.in/nashville'
alias starwars='telnet towel.blinkenlights.nl'
alias icloud='cd /Library/Mobile Documents/com~apple~CloudDocs'
alias monitor='ssh -L 5000:127.0.0.1:5000 michael_mead@musiccitytalent.com' # forward port of server to client browser
alias rasberry="ssh pi@10.0.0.135"
alias ll='ls -l' # display long format directory
alias l.='ls -d .*' #display all dir/ entries that begin with a '.'
alias lc='ls -c' #List in column mode.
alias lS='ls -S' #List by size.
alias ld='ls -d' #List by time and date.
alias sha='shasum -a 256 ' #Test the checksum of a file.
alias grep='grep --color -n'
alias ping='ping -c 5' #Limit ping to 5 attempts.
alias www='python -m SimpleHTTPServer 8000' #start python 2 webserver.
alias speed='speedtest-cli --server 2406 --simple' #run speed test.
alias ipe='curl ipinfo.io/ip' #Get external ip address
if [ -d "/Applications/Firefox Developer Edition.app" ]; then
    alias fire='open -a "/Applications/Firefox Developer Edition.app" $1'
fi
# source rdr venv
alias sordr='source $HOME/code/raw-data-repository/rdr_client/venv/bin/activate'
alias generate_data='cd $HOME/code/raw-data-repository/rdr_client && ./run_client.sh generate_fake_data.py --num_participants 20 --include_physical_measurements --include_biobank_orders --create_biobank_samples && cd ../rest-api'
# google cloud SDK
#source /Users/meadm1/code/google-cloud-sdk/completion.bash.inc
#source /Users/meadm1/code/google-cloud-sdk/path.bash.inc
#source /Users/meadm1/code/google-cloud-sdk/bin
if [ -f '~/.secrets/secrets' ];then
  source ~/.secrets/secrets
fi
if [ -f '~/.bin/tmuxinator.bash' ];
then 
source ~/.bin/tmuxinator.bash
fi

# colorschemes ---------------------------------------------------------------------------------
# apply vimspectr theme to shell
#[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectr210-dark #load vimspectr on shell startup
#vim(){ sh -c "vim $*"; sh ~/.vimspectr-shell/vimspectr210-dark;  clear; } #restore shell theme on vim exit
# apply the dark snow theme to your shell
[ -n "$PS1" ] && sh ~/.vim/plugged/snow/shell/snow_dark.sh # or use snow_light.sh for light theme

# PATH -------------------------------------------------------------------------------------------------------
PATH="${PATH}:/usr/local"
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
PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# from linux bashrc
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export CLOUD_SDK_REPO=cloud-sdk-jessie

if [[ $platform == 'linux' ]]; then
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

fi
# end linux bashrc

 #fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Things I've used to fix mysql and GAE stuff for historical record.
#LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/meadm1/google-cloud-sdk/path.bash.inc' ]; then source '/Users/meadm1/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/meadm1/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/meadm1/google-cloud-sdk/completion.bash.inc'; fi
if [ ! -L /usr/local/opt/mysql/lib/libmysqlclient.20.dylib ] && [ -f '/usr/local/opt/mysql/lib/libmysqlclient.20.dylib' ]; then
	ln -s /usr/local/opt/mysql@5.7/lib/libmysqlclient.20.dylib /usr/local/opt/mysql/lib/libmysqlclient.20.dylib 
fi

# functions to get stuff done
work() {

    fire https://precisionmedicineinitiative.atlassian.net/secure/RapidBoard.jspa?rapidView=11&projectKey=DA
    pycharm
    cd ~/code/raw-data-repository
    sordr
}

oncall(){
    fire https://docs.google.com/spreadsheets/d/19perFkhnw99buA4ztU6hT5HxQhAUC3kGVXYxF0NV6yE/edit?usp=sharing
  }

#Pandoc/lynx markdown function-----------------------------------------------------------------------------
rmd(){
    pandoc $1 | lynx -stdin
}

# generate a random password
randpw(){ < /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9_\!\@\#\$\%\^\&\*\(\)-+= | head -c${1:-16};echo;}
# Have fun and lolcat EVERYTHING !
# exec 1> >(lolcat >&2)
