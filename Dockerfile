FROM kalilinux/kali-rolling

SHELL ["/bin/bash", "-ic"]

RUN apt update
RUN apt install -y \
    vim \
    wget \
    curl \
    git \
    sudo \
    zip unzip \
    build-essential \
    docker.io \
    docker-compose \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libbz2-dev \
    libsqlite3-dev \
    liblzma-dev \
	python-tk \
	python3-tk tk-dev

RUN apt install -y ttf-mscorefonts-installer

RUN apt install -y libswt-gtk-4-java

WORKDIR /tmp

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install -y ./google-chrome-stable_current_amd64.deb

RUN wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O code_latest_amd64.deb
RUN apt install -y ./code_latest_amd64.deb

# add the user
RUN useradd --create-home toolbox -s /bin/bash
RUN echo "toolbox:toolbox" | chpasswd
RUN usermod -aG sudo toolbox
RUN usermod -aG docker toolbox

USER toolbox
WORKDIR /home/toolbox

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

RUN curl -s "https://get.sdkman.io" | bash

RUN curl https://pyenv.run | bash

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
