# Docker Open Broadcaster Software (OBS)
This container is based on [bb12489/gui-docker](https://github.com/bb12489/gui-docker) & [bb12489/docker-obs](https://github.com/bb12489/docker-obs). The OBS with NDI is incorporated into the container and can be used to stream your desktop.

Here is a screenshot:
![Alt](https://raw.githubusercontent.com/bb12489/docker-obs/master/screenshot.png "Example screenshot")

# To run
You can start the container with:

`docker run --shm-size=256m -it -p 5900:5900 -p 5901:5901 -e VNC_PASSWD=123456 -v path to data:/config daedilus1/docker-obs-ndi:latest`

or

`docker create \
  --name=OBS-NDI \
  -p 5900:5900 \
  -p 5901:5901 \
  -v path to data:/config \
  daedilus1/docker-obs-ndi`
  

The shm-size argument is to make sure that the webclient does not run out of shared memory and crash. You can change the default VNC password of '123456' on the docker run command to whatever you wish.

You can connect with your own VNC client at 5900 or use the webclient at 5901
