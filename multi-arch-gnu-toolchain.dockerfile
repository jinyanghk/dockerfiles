FROM ubuntu:24.04

RUN    apt update                   \
    && apt install -y               \
       build-essential              \
       autotools-dev                \
       autoconf                     \
       cmake                        \
       ninja-build                  \
       git                          \
       gdb                          \
       gdb-multiarch                \
       qemu-system-misc             \
       qemu-system-arm              \
       qemu-system-i386             \
       qemu-system-x86              \
       qemu-system-loongarch64      \
       gcc-13-loongarch64-linux-gnu \
       gcc-riscv64-linux-gnu        \
       gcc-arm-linux-gnueabi        \
       g++-arm-linux-gnueabi        \
       gcc-arm-linux-gnueabihf      \
       g++-arm-linux-gnueabihf      \
       gcc-aarch64-linux-gnu        \
       g++-aarch64-linux-gnu        \
       gcc-arm-none-eabi            \
       binutils-riscv64-linux-gnu   \
       sudo                         \
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
