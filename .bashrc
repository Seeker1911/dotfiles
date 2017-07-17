# customize display --------------------------------------------------------------------------------------
# Command Line color prompts ------------------------------------------------------------------------------
export CLICOLOR=1
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export LSCOLORS=ExFxBxDxCxegedabagacad
# symlinks -----------------------------------------------------------------------------------------------
export rasberry="ssh pi@10.0.0.135"
alias ls='ls -GFh'
alias tmux='tmux -2'
alias scratch='vim scratchpad.sh'
export TERM=screen-256color
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
# historian ------------------------------------------------------------------------------------------------------------
alias hist="/Users/michaelmead/Documents/Programming/historian/hist"
export hist import >> ~/.profile

# PATH ------------------------------------------------------------------------------------------------------------------
PATH="$HOME/bin:$PATH"
PATH="${PATH}:/usr/local/sbin"
# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
PATH="$PATH:/Users/michaelmead/Documents/Programming/historian"
PATH="${PATH}:/usr/local/sbin"
PATH="${PATH}:/usr/local"
# added by Anaconda3 4.2.0 installer
PATH="/Users/michaelmead/anaconda/bin:$PATH"
# SET A HOME/BIN PATH FOR SHELL SCRIPTS
PATH="$HOME/bin:$PATH"
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

