# Command Line color prompts ------------------------------------------------------------------------------
export CLICOLOR=1
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # a full PS1 prompt
export PS1="\[\033[32m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR='vim'
# for dark background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export GOPATH=$HOME/code/go
export GOBIN=$HOME/code/go/bin
export MYSQL_ROOT_PASSWORD='root'
export FZF_DEFAULT_OPTS='--height 40% --border'
export rasberry="ssh pi@10.0.0.135"
# aliases -----------------------------------------------------------------------------------------------
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
alias vim='/usr/local/bin/vim'
# use hub as default for git https://hub.github.com/
alias git=hub
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
# forwar port of server to client browser
alias monitor='ssh -L 5000:127.0.0.1:5000 michael_mead@musiccitytalent.com'
# display long format directory
alias ll='ls -l'
#display all dir/ entries that begin with a '.'
alias l.='ls -d .*'
# source rdr venv
alias sordr='source $HOME/code/raw-data-repository/rdr_client/venv/bin/activate'
alias generate_data='cd $HOME/code/raw-data-repository/rdr_client && ./run_client.sh generate_fake_data.py --num_participants 20 --include_physical_measurements --include_biobank_orders --create_biobank_samples'
# shell history ignores repeat commands
export HISTCONTROL=ig-noredups
# increase command history to 1000 (default is 500)
export HISTSIZE=5000
# google cloud SDK
#source /Users/meadm1/code/google-cloud-sdk/completion.bash.inc
#source /Users/meadm1/code/google-cloud-sdk/path.bash.inc
#source /Users/meadm1/code/google-cloud-sdk/bin
source ~/.secrets/secrets
# colorschemes ---------------------------------------------------------------------------------
# vimspectr colortheme save when exiting vim
[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectrgrey-dark
vim(){ sh -c "vim $*"; sh ~/.vimspectr-shell/vimspectr210-dark;  clear; }
# historian -------------------------------------------------------------------------------------------------
alias hist="$HOME/Documents/Programming/historian/hist"
export hist import 
#Pandoc/lynx markdown function-----------------------------------------------------------------------------
rmd(){
    pandoc $1 | lynx -stdin
}

# generate a random password
randpw(){ < /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9_\!\@\#\$\%\^\&\*\(\)-+= | head -c${1:-16};echo;}

# PATH -------------------------------------------------------------------------------------------------------
PATH="${PATH}:/usr/local"
PATH="${PATH}:/usr/local/sbin"
PATH="/usr/local/bin:$PATH"
# SET A HOME/BIN PATH FOR SHELL SCRIPTS
PATH="$HOME/bin:$PATH"
# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
# added by Anaconda3 5.0.0 installer
if [ -d $HOME/anaconda3 ]; then
	export PATH="$HOME/anaconda3/bin:$PATH"
fi
PATH="$PATH:$HOME/Documents/Programming/historian"
export PATH
# fuzzy finder in bash 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export GOOGLE_APPLICATION_CREDENTIALS="~/all-of-us-rdr-stable-f3c2d774fd93.json"
# Things I've used to fix mysql and GAE stuff for historical record.
#LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/meadm1/google-cloud-sdk/path.bash.inc' ]; then source '/Users/meadm1/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/meadm1/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/meadm1/google-cloud-sdk/completion.bash.inc'; fi
if [ ! -L /usr/local/opt/mysql/lib/libmysqlclient.20.dylib ]; then
	ln -s /usr/local/lib/libmysqlclient.20.dylib /usr/local/opt/mysql/lib/libmysqlclient.20.dylib
fi
