FROM bb12489/gui-docker:latest

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && add-apt-repository ppa:graphics-drivers/ppa \
    && apt-get update -y \
    && apt-get install -y obs-studio \
    && apt-get install -y vlc \
    && apt-get install nvidia-driver-430 \
    && apt-get clean -y \
    

RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"VLC\" command=\"vlc\"" >> /usr/share/menu/custom-docker && update-menus
