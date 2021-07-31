source ~/.bashrc
eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
