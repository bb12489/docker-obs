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
    && apt-get install -y module-init-tools \
    && apt-get install -y avahi-daemon \
    && apt-get clean -y \
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus

RUN wget -q -O /tmp/libndi4_4.5.1-1_amd64.deb https://github.com/Palakis/obs-ndi/releases/download/4.9.1/libndi4_4.5.1-1_amd64.deb
RUN wget -q -O /tmp/obs-ndi_4.9.1-1_amd64.deb https://github.com/Palakis/obs-ndi/releases/download/4.9.1/obs-ndi_4.9.1-1_amd64.deb
RUN dpkg -i /tmp/*.deb
RUN /etc/init.d/dbus start
RUN /etc/init.d/avahi-daemon start
