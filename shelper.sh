# see whats running on a port
lsof -i :8080

#Fix brew link permission issues
sudo chown -R `whoami`:admin /usr/local/sbin

#tell git what your global gitignore is
git config --global core.excludesfile ~/.gitignore_global
