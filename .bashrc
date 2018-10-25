# Command Line color prompts ------------------------------------------------------------------------------
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # a full PS1 prompt
# if colorschemes don't overide cli, use these options.
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
# for dark background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export PS1="\[\033[32m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
export EDITOR='vim'
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export FZF_DEFAULT_OPTS='--height 40% --border'
export HISTSIZE=5000
# fix tmux panes history
shopt -s histappend
shopt -s histreedit
shopt -s histverify

HISTCONTROL='ingoreboth'
PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"

# start TMUX by default. If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2
# aliases -----------------------------------------------------------------------------------------------
# set to vi keybindings.
set -o vi
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
alias vim='/usr/local/bin/vim'
alias mysql@5.7='mysql'
# use hub as default for git https://hub.github.com/
alias git=hub
alias listen="netstat -nap tcp | grep -i 'listen'"
alias python='python'
alias server="python -m simpleHTTPServer 8000"
alias ls='ls -GFh'
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
source ~/.secrets/secrets

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
# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
# added by Anaconda3 5.0.0 installer
#if [ -d $HOME/anaconda3 ]; then
#  PATH="$HOME/anaconda3/bin:$PATH"
#fi
PATH="/usr/local/opt/gettext/bin:$PATH"
PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Things I've used to fix mysql and GAE stuff for historical record.
#LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/meadm1/google-cloud-sdk/path.bash.inc' ]; then source '/Users/meadm1/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/meadm1/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/meadm1/google-cloud-sdk/completion.bash.inc'; fi
if [ ! -L /usr/local/opt/mysql/lib/libmysqlclient.20.dylib ]; then
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
    fire https://docs.google.com/spreadsheets/d/19perFkhnw99buA4ztU6hT5HxQhAUC3kGVXYxF0NV6yE/
  }

#Pandoc/lynx markdown function-----------------------------------------------------------------------------
rmd(){
    pandoc $1 | lynx -stdin
}

# generate a random password
randpw(){ < /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9_\!\@\#\$\%\^\&\*\(\)-+= | head -c${1:-16};echo;}
# Have fun and lolcat EVERYTHING !
# exec 1> >(lolcat >&2)
