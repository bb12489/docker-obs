[![Docker Stars](https://img.shields.io/docker/stars/bb12489/docker-obs.svg?style=flat-square)](https://hub.docker.com/r/bb12489/docker-obs/)
[![Docker Pulls](https://img.shields.io/docker/pulls/bb12489/docker-obs.svg?style=flat-square)](https://hub.docker.com/r/bb12489/docker-obs/)
[![](https://images.microbadger.com/badges/image/bb12489/docker-obs.svg)](https://microbadger.com/images/bb12489/docker-obs "Get your own image badge on microbadger.com")

[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoff.ee/bb12489)

# Docker Open Broadcaster Software (OBS)
This container is based on [bb12489/gui-docker](https://github.com/bb12489/gui-docker) & [bb12489/docker-obs](https://github.com/bb12489/docker-obs). The OBS with NDI is incorporated into the container and can be used to stream your desktop.

Here is a screenshot:
![Alt](https://raw.githubusercontent.com/bb12489/docker-obs/master/screenshot.png "Example screenshot")

# To run
You can start the container with:

`docker run --shm-size=256m -it -p 5901:5901 -e VNC_PASSWD=123456 bb12489/docker-obs`

The shm-size argument is to make sure that the webclient does not run out of shared memory and crash. You can change the default VNC password of '123456' on the docker run command to whatever you wish.
