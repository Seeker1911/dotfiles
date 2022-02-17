# Install tmux on rhel/centos 7

# What do we want?
libeventversion=2.1.11
tmuxversion=3.1

# install deps
yum install gcc kernel-devel make ncurses-devel

# DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
curl -OL "https://github.com/libevent/libevent/releases/download/release-$libeventversion-stable/libevent-$libeventversion-stable.tar.gz"
tar -xvzf "libevent-$libeventversion-stable.tar.gz"
cd "libevent-$libeventversion-stable"
./configure --prefix=/usr/local
make
sudo make install
cd ..

# DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL
curl -OL "https://github.com/tmux/tmux/releases/download/$tmuxversion/tmux-$tmuxversion.tar.gz"
tar -xvzf "tmux-$tmuxversion.tar.gz"
cd "tmux-$tmuxversion"
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install
cd ..

# pkill tmux
# close your terminal window (flushes cached tmux executable)
# open new shell and check tmux version
tmux -V
