FROM bb12489/gui-docker:latest

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && add-apt-repository ppa:graphics-drivers/ppa \
    && apt-get update -y \
    && apt-get install -y ffmpeg \
    && apt-get install -y obs-studio \
    && apt-get install -y vlc \
    && apt-get install -y nvidia-driver-440 \
    && apt-get clean -y \
    

RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus

