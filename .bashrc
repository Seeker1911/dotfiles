# customize display --------------------------------------------------------------------------------------
# Command Line color prompts ------------------------------------------------------------------------------
export CLICOLOR=1
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # a full PS1 prompt
export PS1="\[\033[32m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
#export LSCOLORS=ExFxBxDxCxegedabagacad
# for dark background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# symlinks -----------------------------------------------------------------------------------------------
export GOPATH=$HOME/code/go
export GOBIN=$HOME/code/go/bin
export MYSQL_ROOT_PASSWORD='root'
export FZF_DEFAULT_OPTS='--height 40% --border'
export rasberry="ssh pi@10.0.0.135"
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
alias vim='/usr/local/bin/vim'
alias python='python'
alias server="python -m simpleHTTPServer 8000"
alias ls='ls -GFh'
alias tmux='tmux -2'
alias scratch='vim ~/Documents/Programming/scratchpad.sh'
alias dunnet='emacs -batch -l dunnet'
alias play='ls /usr/share/emacs/22.1/lisp/play' 
# tmux screen colors.
# export TERM=screen-256color
# bash/vim screen colors.
# export TERM=xterm-256color
# set up alias for icloud drive
alias icloud='cd /Library/Mobile Documents/com~apple~CloudDocs'
# shell history ignores repeat commands
export HISTCONTROL=ig-noredups
# increase command history to 1000 (default is 500)
export HISTSIZE=1000
# display long format directory
alias ll='ls -l'
#display all dir/ entries that begin with a '.'
alias l.='ls -d .*'
# set alias for programming folder
alias clu='cd ~/Documents/Programming'
source /Users/meadm1/code/google-cloud-sdk/completion.bash.inc
source /Users/meadm1/code/google-cloud-sdk/path.bash.inc
export monitor='ssh -L 5000:127.0.0.1:5000 michael_mead@musiccitytalent.com'
# vimspectr colortheme
[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectr210curve-dark 
# return to bash colorscheme after vim exit (if different)
vim(){ sh -c "vim $*"; sh ~/.vimspectr-shell/vimspectr210curve-dark;  clear; }
# set directory colors
#eval `dircolors ~/.vimspectr-shell/dircolors`
# historian ------------------------------------------------------------------------------------------------------------
alias hist="$HOME/Documents/Programming/historian/hist"
export hist import >> ~/.profile
#Pandoc/lynx markdown function-----------------------------------------------------------------------------------------------------------------------
rmd(){
    pandoc $1 | lynx -stdin
}
# PATH ------------------------------------------------------------------------------------------------------------------
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
