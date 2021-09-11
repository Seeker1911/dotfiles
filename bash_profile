source ~/.bashrc
eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
# macos path fixes
CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include" LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib"

export PATH="/Users/michaelmead/.ebcli-virtual-env/executables:$PATH"
