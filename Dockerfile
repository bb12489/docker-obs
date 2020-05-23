FROM    ubuntu:18.04
# for the VNC connection
EXPOSE 5900
# for the browser VNC client
EXPOSE 5901
# Use environment variable to allow custom VNC passwords
ENV VNC_PASSWD=123456
# Make sure the dependencies are met
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt install -y tigervnc-standalone-server fluxbox xterm git net-tools python python-numpy scrot wget && git clone --branch v1.0.0 --single-branch https://github.com/novnc/noVNC.git /opt/noVNC && git clone --branch v0.8.0 --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify && ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html && wget -q -O /opt/container_startup.sh https://raw.githubusercontent.com/Daedilus/docker-obs-ndi/master/container_startup.sh && wget -q -O /opt/x11vnc_entrypoint.sh https://raw.githubusercontent.com/Daedilus/docker-obs-ndi/master/x11vnc_entrypoint.sh && mkdir /opt/startup_scripts
# Copy various files to their respective places
# Add menu entries to the container
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update -y \
    && apt-get install -y obs-studio \
    && apt-get install -y vlc \
    && sed -i 's/geteuid/getppid/' /usr/bin/vlc \
    && apt-get install -y module-init-tools \
    && apt-get install -y avahi-daemon \
    && apt-get clean -y \
    && wget -q -O /tmp/libndi4_4.5.1-1_amd64.deb https://github.com/Palakis/obs-ndi/releases/download/4.9.1/libndi4_4.5.1-1_amd64.deb \
    && wget -q -O /tmp/obs-ndi_4.9.1-1_amd64.deb https://github.com/Palakis/obs-ndi/releases/download/4.9.1/obs-ndi_4.9.1-1_amd64.deb \
    && dpkg -i /tmp/*.deb \
    && /etc/init.d/dbus start \
    && /etc/init.d/avahi-daemon start \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /opt/container_startup.sh \
    && chmod +x /opt/x11vnc_entrypoint.sh \
    && mkdir /config \
    && ln -s /config /root/.config/obs-studio
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus \
    && echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"Xterm\" command=\"xterm -ls -bg black -fg white\"" >> /usr/share/menu/custom-docker && update-menus
VOLUME ['/config']
ENTRYPOINT ["/opt/container_startup.sh"]
