FROM    ubuntu:18.04
ARG DEBIAN_FRONTEND="noninteractive"
# for the VNC connection
EXPOSE 5900
# for the browser VNC client
EXPOSE 5901
# Use environment variable to allow custom VNC passwords
ENV VNC_PASSWD=123456
ENV HOME="/config"
# Make sure the dependencies are met
RUN apt-get update \
	&& apt install -y tigervnc-standalone-server fluxbox xterm git net-tools python python-numpy scrot wget software-properties-common vlc module-init-tools avahi-daemon \
	&& sed -i 's/geteuid/getppid/' /usr/bin/vlc \
    && add-apt-repository ppa:obsproject/obs-studio \
	&& git clone --branch v1.0.0 --single-branch https://github.com/novnc/noVNC.git /opt/noVNC \
	&& git clone --branch v0.8.0 --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify \
	&& ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html \
# Copy various files to their respective places
	&& wget -q -O /opt/container_startup.sh https://raw.githubusercontent.com/Daedilus/docker-obs-ndi/master/container_startup.sh \
	&& wget -q -O /opt/x11vnc_entrypoint.sh https://raw.githubusercontent.com/Daedilus/docker-obs-ndi/master/x11vnc_entrypoint.sh \
	&& mkdir /opt/startup_scripts
# Update apt for the new obs repository
RUN apt-get update \
    && apt install -y obs-studio \
    && apt-get clean -y \
# Download and install the plugins for NDI
    && wget -q -O /tmp/libndi4_4.5.1-1_amd64.deb https://github.com/Palakis/obs-ndi/releases/download/4.9.1/libndi4_4.5.1-1_amd64.deb \
    && wget -q -O /tmp/obs-ndi_4.9.1-1_amd64.deb https://github.com/Palakis/obs-ndi/releases/download/4.9.1/obs-ndi_4.9.1-1_amd64.deb \
    && dpkg -i /tmp/*.deb \
    && /etc/init.d/dbus start \
    && /etc/init.d/avahi-daemon start \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /opt/container_startup.sh \
    && chmod +x /opt/x11vnc_entrypoint.sh \
    && mkdir /config \
    && mkdir -p /root/.config/obs-studio 
#    && ln -s /root/.config/obs-studio /config
# Add menu entries to the container
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker \
    && echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"Xterm\" command=\"xterm -ls -bg black -fg white\"" >> /usr/share/menu/custom-docker && update-menus
VOLUME ["/config"]
ENTRYPOINT ["/opt/container_startup.sh"]
