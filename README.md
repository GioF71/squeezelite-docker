# squeezelite-docker - a Docker image for SqueezeLite

## Reference

First and foremost, the reference to the awesome project:

[Man page of SqueezeLite](https://ralph-irving.github.io/squeezelite.html)

## Links
Source: [GitHub](https://github.com/giof71/squeezelite-docker)<br />
Images: [DockerHub](https://hub.docker.com/r/giof71/squeezelite)

## Why

I prepared this Dockerfile Because I wanted to be able to install squeezelite easily on any machine (provided the architecture is amd64 or arm). Also I wanted to be able to configure and govern the parameters easily, with particular reference to the configuration of the ALSA output. Configuring the container is easy through a webapp like Portainer.

## Prerequisites

You need to have Docker up and running on a Linux machine, and the current user must be allowed to run containers (this usually means that the current user belongs to the "docker" group).

You can verify whether your user belongs to the "docker" group with the following command:

`getent group | grep docker`

This command will output one line if the current user does belong to the "docker" group, otherwise there will be no output.

The Dockerfile and the included scripts have been tested on the following distros:

- Manjaro Linux with Gnome (amd64)
- Asus Tinkerboard
- Raspberry Pi 3 (but I have no reason to doubt it will also work on a Raspberry Pi 4/400)

As I test the Dockerfile on more platforms, I will update this list.

## Get the image

Here is the [repository](https://hub.docker.com/repository/docker/giof71/squeezelite) on DockerHub.

Getting the image from DockerHub is as simple as typing:

`docker pull giof71/squeezelite:stable`<br />

You may want to pull the "stable" image as opposed to the "latest".

## Usage

You can start mpd-alsa by simply typing:

`docker run -d --rm --device /dev/snd --net host giof71/squeezelite:stable`

Note that we need to allow the container to access the audio devices through /dev/snd.
We also need to use the *host* network so the squeezelite instance can be discovered on your network.

The following tables reports all the currently supported environment variables.

| VARIABLE | DEFAULT | NOTES |
| ------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| SQUEEZELITE_AUDIO_DEVICE | default | The audio device. Common examples: hw:CARD=x20,DEV=0 or hw:CARD=DAC,DEV=0 for usb dac based on XMOS |
| SQUEEZELITE_DELAY | 500 | maybe something like 500,dop if your DAC supports DoP |
| SQUEEZELITE_NAME | SqueezeLite | Name of the SqueezeLite endpoint |
| SQUEEZELITE_TIMEOUT | 2 | Device timeout in seconds |
| SQUEEZELITE_SPECIFY_SERVER | no | Set to yes if you want to specify the server |
| SQUEEZELITE_SERVER_PORT | server:3483 | Server and port of the server |
| STARTUP_DELAY_SEC   | 0 | Delay before starting the application. This can be useful if your container is set up to start automatically, so that you can resolve race conditions with mpd and with squeezelite if all those services run on the same audio device. I experienced issues with my Asus Tinkerboard, while the Raspberry Pi has never really needed this. Your mileage may vary. Feel free to report your personal experience. |
| SQUEEZELITE_TIMEOUT | 2 | Device timeout in seconds |
| SQUEEZELITE_OPTS |  | Other parameters to pass to Squeezelite. e.g. `SQUEEZELITE_OPTS='-r 705600,768000 -R vE::4:28:99:100:50'` to set the max sampling rates and upsampling settings. |

## Build

You can build (or rebuild) the image by opening a terminal from the root of the repository and issuing the following command:

`docker build . -t giof71/squeezelite`

It will take very little time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.<br />
Just be careful to use the tag you have built.
