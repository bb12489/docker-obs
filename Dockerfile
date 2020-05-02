FROM bb12489/gui-docker:latest

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update -y \
    && apt-get install -y obs-studio \
    && apt-get install -y vlc \
    && sed -i 's/geteuid/getppid/' /usr/bin/vlc \
    && apt-get install -y wget \
    && apt-get clean -y \
    && wget http://us.download.nvidia.com/XFree86/Linux-x86_64/440.82/NVIDIA-Linux-x86_64-440.82.run \
    && chmod +x NVIDIA-Linux-x86_64-440.82.run \
    && sh NVIDIA-Linux-x86_64-440.82.run --extract-only \

    

RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\""

RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"VLC\" command=\"vlc\"" >> /usr/share/menu/custom-docker && update-menus

