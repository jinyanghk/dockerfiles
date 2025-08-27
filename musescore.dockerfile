FROM ubuntu:24.04

RUN    apt update            \
    && apt install -y        \
       build-essential       \
       git                   \
       cmake                 \
       libasound2-dev        \
       portaudio19-dev       \
       libmp3lame-dev        \
       libsndfile1-dev       \
       libportmidi-dev       \
       libssl-dev            \
       libpulse-dev          \
       libfreetype6-dev      \
       libfreetype6          \
       libdrm-dev            \
       libgl1-mesa-dev       \
       libegl1-mesa-dev      \
       qtbase5-dev           \
       qttools5-dev          \
       qttools5-dev-tools    \
       qtwebengine5-dev      \
       qtscript5-dev         \
       libqt5xmlpatterns5-dev \
       libqt5svg5-dev        \
       libqt5webkit5-dev     \
       qtbase5-private-dev   \
       libqt5x11extras5-dev  \
       qtdeclarative5-dev    \
       qtquickcontrols2-5-dev \
       qt6-base-dev          \
       qt6-base-private-dev  \
       qt6-networkauth-dev   \
       qt6-declarative-dev   \
       qt6-scxml-dev         \
       qt6-svg-dev           \
       qt6-tools-dev         \
       qt6-5compat-dev       \
       qml6-module-*         \
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
