# customize display --------------------------------------------------------------------------------------
# Command Line color prompts ------------------------------------------------------------------------------
export CLICOLOR=1
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # a full PS1 prompt
export PS1="\[\033[32m\]seeker\[\033[m\]\[\033[36;1m\]\w\[\033[m\]\$ "
#export LSCOLORS=ExFxBxDxCxegedabagacad
# for dark background
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# symlinks -----------------------------------------------------------------------------------------------
export rasberry="ssh pi@10.0.0.135"
# use the homebrew vim 8 instead of system vim (system vim is at /usr/bin/vim)
alias vim='/usr/local/bin/vim'
alias python='python3'
alias server="python -m simpleHTTPServer 8000"
alias ls='ls -GFh'
alias tmux='tmux -2'
alias scratch='vim ~/Documents/Programming/scratchpad.sh'
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

export monitor='ssh -L 5000:127.0.0.1:5000 michael_mead@musiccitytalent.com'
# vimspectr colortheme
[ -n "$PS1" ] && sh ~/.vimspectr-shell/vimspectr210curve-dark 
# return to bash colorscheme after vim exit (if different)
vim(){ sh -c "vim $*"; sh ~/.vimspectr-shell/vimspectr210curve-dark;  clear; }
# set directory colors
#eval `dircolors ~/.vimspectr-shell/dircolors`
# historian ------------------------------------------------------------------------------------------------------------
alias hist="/Users/michaelmead/Documents/Programming/historian/hist"
export hist import >> ~/.profile

# PATH ------------------------------------------------------------------------------------------------------------------
#PATH="$HOME/bin:$PATH"
PATH="${PATH}:/usr/local/sbin"
# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
PATH="$PATH:/Users/michaelmead/Documents/Programming/historian"
#PATH="${PATH}:/usr/local/sbin"
PATH="${PATH}:/usr/local"
# added by Anaconda3 4.2.0 installer
# PATH="/Users/michaelmead/anaconda/bin:$PATH"
# SET A HOME/BIN PATH FOR SHELL SCRIPTS
PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"
export PATH

# PYENV ----------------------------------------------------------------------------------------------------------------------
# COMMENTING OUT PYENV TO TEST ANACONDA COMPATABILITY >>>>>>>>>>>>>>>>>>>>>>>>
#export PYENV_ROOT="$HOME/.pyenv"

#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#POWERLINE --------------------------------------------------
#powerline-daemon -q 
#. /anaconda/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh


#
# Hack to get python 2.7
#
#export PYTHON27_HOME=/Library/Frameworks/Python.framework/Versions/2.7
#export PATH=$PATH:$PYTHON27_HOME/bin

#
#-- End of Hack

# added by Anaconda3 5.0.0 installer
export PATH="/Users/michaelmead/anaconda3/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
