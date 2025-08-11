FROM ubuntu:24.04

RUN    apt update            \
    && apt install -y        \
       autoconf              \
       automake              \
       autotools-dev         \
       curl                  \
       python3               \
       python3-pip           \
       python3-tomli         \
       libmpc-dev            \
       libmpfr-dev           \
       libgmp-dev            \
       gawk                  \
       build-essential       \
       bison                 \
       flex                  \
       texinfo               \
       gperf                 \
       libtool               \
       patchutils            \
       bc                    \
       zlib1g-dev            \
       libexpat-dev          \
       ninja-build           \
       git                   \
       cmake                 \
       libglib2.0-dev        \
       libslirp-dev          \
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

ARG VERSION=2025.07.16

RUN    cd ~                                                                             \
    && git clone https://github.com/riscv/riscv-gnu-toolchain                           \
    && cd riscv-gnu-toolchain                                                           \
    && git checkout $VERSION                                                            \
    && sudo ./configure --prefix=/opt/riscv --enable-multilib --enable-qemu-system      \
    && sudo make build-sim SIM=qemu                                                     \
    && sudo make                                                                        \
    && cd ..                                                                            \
    && sudo rm -rf riscv-gnu-toolchain                                                  \
    && echo "export PATH=/opt/riscv/bin:\$PATH" >> ~/.bashrc

WORKDIR /home/$USERNAME

CMD ["/bin/bash"]
