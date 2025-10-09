FROM ubuntu:18.04

RUN    apt update            \
    && apt install -y        \
       build-essential       \
       autotools-dev         \
       autoconf              \
       cmake                 \
       ninja-build           \
       git                   \
       gdb                   \
       gawk                  \
       flex                  \
       bison                 \
       xxd                   \
       iproute2              \
       zlib1g-dev            \
       qemu-system-i386      \
       sudo                  \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure sudo \
    && groupadd $USERNAME \
    && useradd -u $USER_UID $USERNAME -g $USERNAME \
    && mkdir /home/$USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

WORKDIR /home/$USERNAME

CMD ["/bin/bash"]
