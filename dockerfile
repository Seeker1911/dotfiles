FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM=xterm-256color
ENV EDITOR /usr/bin/vim
ENV CONFIG_DIR /root/.config

# Install a bunch of "necessary" things
# first the https transport to allow installing from https urls later.
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && \
	apt-get install -y software-properties-common && \
  add-apt-repository ppa:neovim-ppa/stable && \
  apt-get install -y \
      apt-utils \
      locales \
      mosh \
      tmux  \
      neovim  \
      python3-neovim \
      nnn \
      python \
      python3.7 \
      python3.8 \
      python-dev \
      python-pip \
      python3-dev \
      python3-pip \
      curl \
      git \
      wget \
      language-pack-en \
      zip \
      jq \
      ruby \
      openjdk-8-jdk \
      markdown \
      lynx \
      xdotool \
      libncurses5-dev \
      autoconf \
      iputils-ping \
      silversearcher-ag \
      pylint \
      erlang \ 
      docker.io \
      docker-compose \
      ngrep \
      linux-tools-4.15.0.20 \
      valgrind \
      openjfx \
      tidy \
      moreutils \ 
      exiftool \ 
      atool \ 
      patool \ 
      vlock

# Config timezone
ENV TZ America/Chicago
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install neovim and some other python stuff
RUN pip install --upgrade pip mock neovim grip && \
  update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 && \
  update-alternatives --config vi && \
  update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 && \
  update-alternatives --config vim && \
  update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 && \
  update-alternatives --config editor

# Install nvm
ENV NVM_VERSION 0.33.8
ENV NVM_DIR ${CONFIG_DIR}/nvm
ENV NODE_VERSION 12.16.1
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash
RUN \. $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION \
        && nvm alias default $NODE_VERSION \
	&& nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# export NVM_DIR="$HOME/.nvm"
#CMD ["/bin/bash", "[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" "] # This loads nvm



# Install shell plugins
RUN curl -fLo ${CONFIG_DIR}/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --silent
RUN git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh && cd .. && rm -rf fonts

# Install go
ENV GOVERSION 1.14
#ENV GOROOT /opt/go
ENV GOPATH /root/go
RUN cd /opt && wget --quiet https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz && \
  tar zxf go${GOVERSION}.linux-amd64.tar.gz && rm go${GOVERSION}.linux-amd64.tar.gz && \
  ln -s /opt/go/bin/go /usr/bin/ && \
  mkdir $GOPATH


# Install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add && \
  apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" && \
  apt-get install kubectl


# Config vim
ADD vimrc $CONFIG_DIR/nvim/init.vim
RUN nvim +PlugInstall +qall +silent

RUN git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm
ENV TMUX_PLUGIN_MANAGER_PATH /root/.tmux/plugins/tpm
# start a server but don't attach to it
RUN tmux start-server
# create a new session but don't attach to it either
RUN tmux new-session -d
# install the plugins
RUN /root/.tmux/plugins/tpm/scripts/install_plugins.sh
#RUN tmux kill-server

# install pyenv
#RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
#ENV PYENV_ROOT $HOME/.pyenv
#ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

#RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> .bashrc
#RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> .bashrc
#RUN echo 'eval "$(pyenv init -)"' >> .bashrc

#RUN pyenv install 2.7.6
#RUN pyenv install 3.7.8
#RUN pyenv install 3.8.2
#RUN pyenv global 3.7.6
#RUN pyenv rehash
# setup pyenv virtualenv
#RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
#RUN pyenv virtualenv 3.7.8 neovim3
#RUN pyenv virtualenv 2.7.6 neovim2

# Add additional configs
ADD tmux.conf /root/.tmux.conf
ADD bashrc /root/.bashrc
ADD linters/pylintrc $CONFIG_DIR/pylintrc
ADD Brewfile $CONFIG_DIR/Brewfile
ADD coc-settings.json $CONFIG_DIR/nvim/coc-settings.json

#WORKDIR /src
WORKDIR /root

VOLUME /src
VOLUME /root
VOLUME /keys

CMD ["tmux"]

