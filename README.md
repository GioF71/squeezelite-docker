# squeezelite-docker - a Docker image for SqueezeLite

Now with support for upsampling.

## Reference

First and foremost, the reference to the awesome project:

[Man page of SqueezeLite](https://ralph-irving.github.io/squeezelite.html)

This page will also be useful when tuning the parameters.
In case you want to play with upsampling, this other page might be very helpful:

[Archimago - MUSINGS: More fun with digital filters!](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html)

## Links

Source: [GitHub](https://github.com/giof71/squeezelite-docker)  
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
- DietPi on Asus Tinkerboard
- Raspberry Pi OS on Raspberry Pi 3 (but I have no reason to doubt it will also work on a Raspberry Pi 4/400)

As I test the Dockerfile on more platforms, I will update this list.

## Get the image

Here is the [repository](https://hub.docker.com/repository/docker/giof71/squeezelite) on DockerHub.

Getting the image from DockerHub is as simple as typing:

`docker pull giof71/squeezelite:stable`

You may want to pull the "stable" image as opposed to the "latest".

## Usage

You can start squeezelite by typing:

`docker run -d --rm --network host --device /dev/snd giof71/squeezelite:stable`

Note that we need to allow the container to access the audio devices through /dev/snd.  
We also need to use the *host* network mode so the squeezelite instance can be discovered on your network.  
The host network mode is generally not necessary if you specify your server (and port) using the environment variable `SQUEEZELITE_SERVER_PORT`.

The following tables reports all the currently supported environment variables.

VARIABLE|DEFAULT|NOTES
---|---|---
SQUEEZELITE_AUDIO_DEVICE|default|The audio device. Common examples: hw:CARD=x20,DEV=0 or hw:CARD=DAC,DEV=0 for usb dac based on XMOS.
SQUEEZELITE_DELAY|500|Set it to maybe something like 500,dop if your DAC supports DoP.
SQUEEZELITE_NAME|SqueezeLite|Name of the SqueezeLite endpoint.
SQUEEZELITE_TIMEOUT|2|Device timeout in seconds.
SQUEEZELITE_SERVER_PORT||Server and port of the server, for example: `squeezebox-server.local:3483` or `192.168.1.10:3483`. Do not specify the variable if you want to use the auto discovery feature.
SQUEEZELITE_RATES||From squeezelite's man page for `-r`: Specify sample rates supported by the output device; this is required if the output device is switched off when squeezelite is started. The format is either a single maximum sample rate, a range of sample rates in the format `<min>-<max>`, or a comma-separated list of available rates. Delay is an optional time to wait when switching sample rates between tracks, in milliseconds.
SQUEEZELITE_UPSAMPLING||From squeezelite's man page for `-u`, same as `-R`: Enable upsampling of played audio. The argument is optional; see RESAMPLING for more information. The options `-u` and `-R` are synonymous.
STARTUP_DELAY_SEC|0|Delay before starting the application. This can be useful if your container is set up to start automatically, so that you can resolve race conditions with mpd and with squeezelite if all those services run on the same audio device. I experienced issues with my Asus Tinkerboard, while the Raspberry Pi has never really needed this. Your mileage may vary. Feel free to report your personal experience.

## Upsampling

In case you want to adopt Archimago's 'Goldilocks' suggestion, the variables should be set as follows:

Variable|Value
---|---
SQUEEZELITE_RATES|44100,48000,88200,96000,176400,192000,352800,384000
SQUEEZELITE_UPSAMPLING|v::4:28:95:105:45

## Notable changes to the configuration

A few environment variables have been deprecated, see the following table.

Deprecated Variable|Deprecated Since|Comment
---|---|---
SQUEEZELITE_SPECIFY_SERVER|2021-11-23|This variable is not required anymore: just set the SQUEEZELITE_SERVER_PORT variable

## A few examples

As contributed by [vespadj](https://github.com/vespadj) in [Issue #6](https://github.com/GioF71/squeezelite-docker/issues/6), have a look at this simple `docker-compose` service for the Raspberry Pi on its onboard headphone jack (I only added host network mode so the player is discoverable):

```text
---
version: "3.3"

services:
  squeezelite:
    image: giof71/squeezelite:stable
    container_name: squeezelite
    network_mode: host
    devices: 
      - /dev/snd:/dev/snd
    environment:
      - SQUEEZELITE_NAME=home-pi
      - STARTUP_DELAY_SEC=1
      - SQUEEZELITE_AUDIO_DEVICE=hw:CARD=Headphones,DEV=0
    restart: unless-stopped
```

Please not that `STARTUP_DELAY_SEC` is optional.
The equivalent `docker run` command should be the following:

```text
docker run \
    -it \
    --rm \
    --name squeezelite \ 
    --network host \
    -e SQUEEZELITE_NAME="home-pi" \
    -e SQUEEZELITE_AUDIO_DEVICE="hw:CARD=Headphones,DEV=0" \
    --device /dev/snd \
    giof71/squeezelite:stable
```

As another example, here you can find the docker run command I use for a Fiio E18, which supports sampling rates up to 96kHz (but notably not 88.2kHz) enabling upsampling to 96kHz:

```text
docker run \
    -it \
    --rm \
    --name squeezelite \ 
    -e SQUEEZELITE_NAME="FiioE18" \
    -e SQUEEZELITE_SERVER="192.168.1.10:3483" \
    -e SQUEEZELITE_AUDIO_DEVICE="hw:CARD=DACE18,DEV=0" \
    -e SQUEEZELITE_RATES="96000" \
    -e SQUEEZELITE_UPSAMPLING="v::4:28:95:105:45" \
    --device /dev/snd \
    giof71/squeezelite
```

Another example, with a Topping D10 USB DAC, which supports every sample rate including DSD, you might want to use the following:

```text
docker run \
    -it \
    --rm \
    --name squeezelite \ 
    -e SQUEEZELITE_NAME="ToppingD10" \
    -e SQUEEZELITE_SERVER="192.168.1.10:3483" \
    -e SQUEEZELITE_AUDIO_DEVICE="hw:CARD=D10,DEV=0" \
    -e SQUEEZELITE_DELAY=500 \
    -e SQUEEZELITE_RATES="44100,48000,88200,96000,176400,192000,352800,384000" \
    -e SQUEEZELITE_UPSAMPLING="v::4:28:95:105:45" \
    --device /dev/snd \
    giof71/squeezelite
```

Note that the previous commands are interactive (`-it`) and that the container is automatically removed (`--rm`) when you kill squeezelite for example by using `CTRL-C`.
You might want to use daemon flag (`-d`) and optionally a restart strategy (you might want to use `--restart unless-stopped` if you want your container to restart automatically, unless you explicitly stop it).

Here is my `docker-compose.yaml` file for my office-pi, using tailscale networking, equipped with an hifiberry-pro hat (the one with the headphone amp).
Full upsampling up to 352.8/384 kHz thanks to [ArchImago](https://archimago.blogspot.com/).

```text
---
version: "3.3"

services:
  squeezelite-tailscale:
    image: giof71/squeezelite:stable
    container_name: squeezelite-tailscale
    devices:
      - /dev/snd:/dev/snd
    environment:
      - SQUEEZELITE_NAME=office-pi
      - SQUEEZELITE_AUDIO_DEVICE=hw:CARD=sndrpihifiberry,DEV=0
      - SQUEEZELITE_SERVER_PORT=100.100.100.100:3483
      - SQUEEZELITE_RATES="44100,48000,88200,96000,176400,192000,352800,384000"
      - SQUEEZELITE_UPSAMPLING="v::4:28:95:105:45"
      - STARTUP_DELAY_SEC=0
    restart: unless-stopped
```

Note that `network_mode` is not specified because we are specifying the server we want to connect to.  
When using `SQUEEZELITE_RATES` and `SQUEEZELITE_UPSAMPLING`, please be sure to use sampling rates that are effectively supported by your DAC.

## Build

You can build (or rebuild) the image by opening a terminal from the root of the repository and issuing the following command:

`docker build . -t giof71/squeezelite`

It will take very little time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.
