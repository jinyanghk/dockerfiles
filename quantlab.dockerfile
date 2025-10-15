FROM ubuntu:24.04

ENV LANG=C.UTF-8
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV DBUS_SESSION_BUS_ADDRESS=autolaunch:

RUN apt update -qq && \
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    curl \
    sudo \
    python3-pip \
    python3-venv \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-khmeros \
    fonts-kacst \
    fonts-freefont-ttf \
    dbus \
    dbus-x11

RUN curl -sL https://deb.nodesource.com/setup_22.x -o /tmp/nodesource_setup.sh && \
    bash /tmp/nodesource_setup.sh && \
    apt install -y nodejs && \
    rm /tmp/nodesource_setup.sh

RUN curl --location --silent https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt update -qq && \
    apt install google-chrome-stable -y --no-install-recommends

RUN rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN npm install -g puppeteer && \
    echo export NODE_PATH=/usr/lib/node_modules >> ~/.bashrc && \
    npm cache clean --force


ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure sudo \
    && groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

RUN cd ~ && \
    python3 -m venv .venv &&      \
    . .venv/bin/activate &&       \
    ~/.venv/bin/pip install       \
                    numpy         \
                    sympy         \
                    scipy         \
                    quantlib      \
                    duckdb        \
                    pandas        \
                    jupysql       \
                    duckdb-engine \
                    matplotlib    \
                    yfinance      \
                    yahoo_fin     \
                    jupyterlab    \
                    jupyter       \
                    metakernel    \
                    selenium   && \
    ~/.venv/bin/python3 -c "import duckdb;duckdb.query('install httpfs;');duckdb.query('install json;')" && \
    ~/.venv/bin/pip cache purge && \
    echo export NODE_PATH=/usr/lib/node_modules >> ~/.bashrc && \
    echo export PATH=$PATH:~/.venv/bin >> ~/.bashrc && \
    . ~/.bashrc

WORKDIR /home/$USERNAME

CMD ["/bin/bash"]