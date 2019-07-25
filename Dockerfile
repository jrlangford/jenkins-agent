FROM jenkinsci/ssh-slave

# Upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce

# Add jenkins user to docker group
RUN usermod -aG docker jenkins

# Install python 3.6
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncurses5-dev  libncursesw5-dev xz-utils tk-dev && \
    mkdir /tmp/py-install && \
    cd /tmp/py-install && \
    wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz && \
    tar xvf Python-3.6.4.tgz && \
    cd Python-3.6.4 && \
    ./configure --enable-optimizations && \
    make -j8 && \
    make altinstall

RUN python3.6 -m pip install jinja2

USER jenkins

# Install dserver script
    # https://github.com/jrlangford/docker-server-manager
