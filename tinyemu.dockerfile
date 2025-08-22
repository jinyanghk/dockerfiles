FROM ubuntu:24.04

RUN    apt update            \
    && apt install -y        \
       build-essential       \
       git                   \
       libssl-dev            \
       libcurl4-openssl-dev  \
       libsdl1.2-dev         \
       libsdl-dev            \
       sudo                  \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN dpkg-reconfigure sudo \
    && groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

WORKDIR /home/$USERNAME

CMD ["/bin/bash"]
