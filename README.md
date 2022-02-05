# squeezelite-docker - a Docker image for SqueezeLite

Now with support for upsampling and presets for maximum convenience.
Now also with support for arm64 thanks to [Der-Henning](https://github.com/Der-Henning/)

## Available Archs on Docker Hub

- linux/amd64
- linux/arm/v7
- linux/arm64/v8

## Reference

First and foremost, the reference to the awesome project:

[Man page of SqueezeLite](https://ralph-irving.github.io/squeezelite.html)  
[SqueezeLite binaries on SourceForge](https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/)

This page will also be useful when tuning the parameters.
In case you want to play with upsampling, this other page might be very helpful:

[Archimago - MUSINGS: More fun with digital filters!](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html)

## Links

Source: [GitHub](https://github.com/giof71/squeezelite-docker)  
Images: [DockerHub](https://hub.docker.com/r/giof71/squeezelite)

## Why

I prepared this Dockerfile Because I wanted to be able to install squeezelite easily on any machine (provided the architecture is amd64 or arm). Also I wanted to be able to configure and govern the parameters easily, with particular reference to the configuration of the ALSA output. Configuring the container is easy through a webapp like [Portainer](https://www.portainer.io/).

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

Variable|SqueezeLite corresponding option|Default|Notes
:---|:---:|:---:|:---
PRESET|||You can now choose to set variables using predefined presets. Presets can currently tune the values of `SQUEEZELITE_AUDIO_DEVICE`, `SQUEEZELITE_RATES` and `SQUEEZELITE_UPSAMPLING` for you. See the [Available presets](#available-presets) table for reference. Presets can be combined (the separator must be a comma `,`), but keep in mind that the first preset setting a variable has the priority: that variable cannot be overwritten by other presets.
SQUEEZELITE_AUDIO_DEVICE|-o||The audio device. Common examples: `hw:CARD=x20,DEV=0` or `hw:CARD=DAC,DEV=0` for usb dac based on XMOS. If left empty, the default alsa device is used.
SQUEEZELITE_PARAMS|-a||Please refer to the squeezelite's [man page](https://ralph-irving.github.io/squeezelite.html) for `-a`.
SQUEEZELITE_CODECS|-c||Please refer to the squeezelite's [man page](https://ralph-irving.github.io/squeezelite.html) for `-c`.
SQUEEZELITE_PRIORITY|-p||Please refer to the squeezelite's [man page](https://ralph-irving.github.io/squeezelite.html) for `-p`.
SQUEEZELITE_DELAY|-D|500|Set it to maybe something like `500,dop` if your DAC supports DoP.
SQUEEZELITE_NAME|-n||Name of the SqueezeLite player. Use an alphanumeric string without spaces and/or special characters.
SQUEEZELITE_MODEL_NAME|-M||Name of the SqueezeLite model name. Use an alphanumeric string without spaces and/or special characters.
SQUEEZELITE_MAC_ADDRESS|-m||Mac Address of the SqueezeLite player. The format must be colon-delimited hexadecimal, for example: `ab:cd:ef:12:34:56`.
SQUEEZELITE_TIMEOUT|-C|2|Device timeout in seconds.
SQUEEZELITE_SERVER_PORT|-s||Server and port of the server, for example: `squeezebox-server.local:3483` or `192.168.1.10:3483`. Do not specify the variable if you want to use the auto discovery feature. If you don't specify this variable, you will probably need to use host network mode. See the examples for some hints. The port can be omitted if not different from the default `3483`. So other possible valid values are `squeezebox-server.local` or `192.168.1.10`.
SQUEEZELITE_RATES|-r||From squeezelite's [man page](https://ralph-irving.github.io/squeezelite.html) for `-r`: Specify sample rates supported by the output device; this is required if the output device is switched off when squeezelite is started. The format is either a single maximum sample rate, a range of sample rates in the format `<min>-<max>`, or a comma-separated list of available rates. Delay is an optional time to wait when switching sample rates between tracks, in milliseconds. Switch back to the author of this repository: it is recommended to specify sample rates that are effectively supported by your audio device.
SQUEEZELITE_UPSAMPLING|-u, -R||From squeezelite's [man page](https://ralph-irving.github.io/squeezelite.html) for `-u`, same as `-R`: Enable upsampling of played audio. The argument is optional; see RESAMPLING for more information. The options `-u` and `-R` are synonymous.
SQUEEZELITE_BUFFER_SIZE|-b||From squeezelite's [man page](https://ralph-irving.github.io/squeezelite.html) for `-b`: Specify internal stream and output buffer sizes in kilobytes. Default is 2048:3446.
STARTUP_DELAY_SEC||0|Delay before starting the application. This can be useful if your container is set up to start automatically, so that you can resolve race conditions with mpd and with squeezelite if all those services run on the same audio device. I experienced issues with my Asus Tinkerboard, while the Raspberry Pi has never really needed this. Your mileage may vary. Feel free to report your personal experience.

## Upsampling

In case you want to adopt Archimago's 'Goldilocks' suggestion, the variables should be set as in the following table. Refer to the line which resembles the capabilities of your audio device.

Variable|Audio Device Capabilities|Suggested value
:---|:---:|:---
SQUEEZELITE_RATES|All sampling rates up to 384kHz|44100-384000
SQUEEZELITE_RATES|All sampling rates up to 192kHz|44100-192000
SQUEEZELITE_RATES|All sampling rates up to 96kHz|44100-96000
SQUEEZELITE_RATES|Typical USB Class 1 (88.2kHz is sometimes not supported, so we upsample to 96k)|96000
SQUEEZELITE_UPSAMPLING|Anything higher than 44.1kHz|v::4:28:95:105:45

The `SQUEEZELITE_RATES` displayed here are provided just as an example. You still should verify the capabilities of your particular audio device.

## Available presets

Preset name|Availability date|Set Device|Set Rates|Set Upsampling|Comment
:---|:---:|:---:|:---:|:---:|:---
dac|2022-02-02|Y|N|N|Sets device for typical xmos dac named "DAC"
x20|2022-02-02|Y|N|N|Sets device for typical xmos dac named "x20"
topping-d10|2022-02-02|Y|N|N|Sets device for Topping D10 Dac
gustard-x12|2022-02-02|Y|N|N|Sets device for Gustard X12 DAC
hifiberry-dac-plus|2022-02-02|Y|N|N|Sets device for the HifiBerry Dac+
goldilocks|2022-01-19|N|N|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, rates must be set with another preset or explicitly using the variable `SQUEEZELITE_RATES`. Corresponds to `v::4:28:95:105:45`
extremus|2022-01-19|N|N|Y|Setup [extremus](https://archimago.blogspot.com/2018/11/musings-raspberry-pi-3-b-touch.html) upsampling for usb dac, rates must be set with another preset or explicitly using the variable `SQUEEZELITE_RATES`. Corresponds to `v::3.05:28:99.7:100:45`
archimago-goldilocks|2022-02-04|N|N|Y|Alias for `goldilocks`, name feels more appropriate
archimago-extremus|2022-02-04|N|N|Y|Alias for `extremus`, name feels more appropriate
rates_up_to_96k|2022-02-02|N|Y|N|Set rates to `44100-96000`
rates_up_to_192k|2022-02-02|N|Y|N|Set rates to `44100-192000`
rates_up_to_384k|2022-02-02|N|Y|N|Set rates to `44100-384000`
rates_up_to_768k|2022-02-02|N|Y|N|Set rates to `44100-768000`
rates_2x_only|2022-02-02|N|Y|N|Set rates to `88200,96000`
rates_4x_only|2022-02-02|N|Y|N|Set rates to `176400,192000`
rates_8x_only|2022-02-02|N|Y|N|Set rates to `352800,384000`
rates_16x_only|2022-02-02|N|Y|N|Set rates to `705600,768000`
goldilocks_up_to_96k|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, up to 96kHz
goldilocks_up_to_192k|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, up to 192kHz
goldilocks_up_to_384k|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, up to 384kHz
goldilocks_up_to_768k|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, up to 768kHz
goldilocks_2x_only|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, along with 2x rates only
goldilocks_4x_only|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, along with 4x rates only
goldilocks_8x_only|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, along with 8x rates only
goldilocks_16x_only|2022-01-19|N|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, along with 16x rates only
gustard-x12-goldilocks|2022-01-19|Y|Y|Y|Setup [goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) upsampling for usb dac, up to 384kHz, and also sets output device correctly for a Gustard X12 DAC

## Notable changes to the configuration

A few environment variables have been deprecated, see the following table.

Deprecated Variable|Deprecated Since|Comment
:---|:---|:---
SQUEEZELITE_SPECIFY_SERVER|2021-11-23|This variable is not required anymore: just set the `SQUEEZELITE_SERVER_PORT` variable
SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE|2022-01-24|Variable name too long, replaced with SQUEEZELITE_BUFFER_SIZE

For the new variables introduced over time, see the following table.

New Variable|Availability Date|Comment
:---|:---|:---
SQUEEZELITE_RATES|2021-11-23|Added support for configuration option
SQUEEZELITE_UPSAMPLING|2021-11-23|Added support for configuration option
PRESET|2022-01-19|New feature
SQUEEZELITE_PARAMS|2022-01-19|Added support for configuration option
SQUEEZELITE_CODECS|2022-01-19|Added support for configuration option
SQUEEZELITE_PRIORITY|2022-01-19|Added support for configuration option
SQUEEZELITE_MIXER_DEVICE|2022-01-21|Added support for configuration option
SQUEEZELITE_MAC_ADDRESS|2022-01-21|Added support for configuration option
SQUEEZELITE_MODEL_NAME|2022-01-21|Added support for configuration option
SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE|2022-01-21|Added support for configuration option
SQUEEZELITE_BUFFER_SIZE|2022-01-24|Previous variable was too long.

## A few examples

As contributed by [vespadj](https://github.com/vespadj) in [Issue #6](https://github.com/GioF71/squeezelite-docker/issues/6), have a look at this simple `docker-compose` service for the Raspberry Pi using its onboard headphone jack as the output device (I only added host network mode so the player is discoverable):

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
    -e SQUEEZELITE_RATES="44100-384000" \
    -e SQUEEZELITE_UPSAMPLING="v::4:28:95:105:45" \
    --device /dev/snd \
    giof71/squeezelite
```

Note that the previous commands are interactive (`-it`) and that the container is automatically removed (`--rm`) when you kill squeezelite for example by using `CTRL-C`.
You might want to use daemon flag (`-d`) and optionally a restart strategy (you might want to use `--restart unless-stopped` if you want your container to restart automatically, unless you explicitly stop it).

Here is my `docker-compose.yaml` file for my office-pi, using tailscale networking, equipped with an hifiberry-pro hat (the one with the headphone amp).
Full upsampling up to 176.4/192 kHz thanks to [ArchImago](https://archimago.blogspot.com/).

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
      - SQUEEZELITE_RATES="44100-192000"
      - SQUEEZELITE_UPSAMPLING="v::4:28:95:105:45"
      - STARTUP_DELAY_SEC=0
    restart: unless-stopped
```

Note that `network_mode` is not specified because we are specifying the server we want to connect to.  
When using `SQUEEZELITE_RATES` and `SQUEEZELITE_UPSAMPLING`, please be sure to use sampling rates that are effectively supported by your DAC.

Another `docker-compose.yaml`, this time leveraging presets. This one is for my Gustard X12, setting upsampling again.
The file looks more concise and readable, at least IMO.

```text
--
version: "3"

services:
  squeezelite-gustard-x12:
    image: giof71/squeezelite:bullseye
    container_name: squeezelite-gustard-x12
    devices:
      - /dev/snd:/dev/snd
    environment:
      - PRESET=gustard-x12,goldilocks,rates_up_to_384k
      - SQUEEZELITE_NAME=gustard-x12-usb
      - SQUEEZELITE_SERVER_PORT="192.168.1.10"
```

## Build

You can build (or rebuild) the image by opening a terminal and using the convenience script `build.sh`.
This script accepts a few parameters:

Parameter|Default|Description
:---|:---:|:---
-d|N|Use repository (`N`) or download from SourceForge (`Y`)
-b|bullseye|Base image, you can choose among `bullseye`, `buster` and `focal`
-t|latest|The last part of the tag, by default it will be giof71/squeezelite:latest

Example:

Command|Expected Result
:---|:---
./build.sh|Builds from Debian Bullseye, using the binary version from the repos, use the `latest` tag
./build.sh -d N -b bullseye -t latest|Same as above, but everything is explicitly specified
./build.sh -d Y -b buster -t buster-sf|Builds from Debian Buster, download from SourceForge, use `buster-sf` as the tag.

It will take a few minutes of your time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.

## Docker Hub tags

From this repository I create all the versions of the image. Each of them feature different base images and different way to obtain the squeezelite binary. See the following table for the details.

Tag|Base Image|SqueezeLite Version|SqueezeLite Origin|Additional Tags
:---|:---:|:---:|:---:|:---
latest|debian:bullseye|1.9.9|SourceForge|
stable|debian:buster|1.8|Debian Repositories|
bullseye|debian:bullseye|1.9.8|Debian Repositories|squeezelite-1.9.8-bullseye, squeezelite-1.9.8-bullseye-RELEASE_DATE
buster|debian:buster|1.8|Debian Repositories|squeezelite-1.8-buster, squeezelite-1.8-buster-RELEASE_DATE
sourceforge-buster|debian:buster|1.9.9|SourceForge|squeezelite-1.9.9-sourceforge-buster, squeezelite-1.9.9-sourceforge-buster-RELEASE_DATE
sourceforge-bullseye|debian:bullseye|1.9.9|SourceForge|squeezelite-1.9.9-sourceforge-bullseye, squeezelite-1.9.9-sourceforge-bullseye-RELEASE_DATE
ubuntu-focal|ubuntu:focal|1.8|Ubuntu Repositories|squeezelite-1.8-ubuntu-focal, squeezelite-1.8-ubuntu-focal-RELEASE_DATE

This situation might change in the future. I am currently using `debian:buster` as the base image because I am experiencing high cpu usage on the Raspberry Pi 3b (Raspbian OS Buster being the host o.s.) with `debian:bullseye` based images. Not so with the `debian-bullseye` image along with the squeelite binary from SourceForge.  
So this is why `latest` is currently same as `sourceforge-bullseye` and `stable` is same as `buster` image.  
Also, the `ubuntu-focal` images are currently not very interesting as they feature the same version as the `debian:buster` images, and I am not willing to use non-lts versions of ubuntu, which change way too frequently. So I might drop those builds in the near future.

## Errata

A few images built around SourceForge binaries report wrong and/or misleading tag names: some buster tags would appear to contain SqueezeLite version 1.8 and some bullseye tags would appear to contain SqueezeLite version 1.9.8. In both cases, the included SqueezeLite version is instead 1.9.9.
Sorry for the inconvenience, this is now fixed.

## Release History

Release Date|Major Changes
---|---
2022-02-05|Automated builds thanks to [Der-Henning](https://github.com/Der-Henning/), Builds for amd64 also thanks to [Der-Henning](https://github.com/Der-Henning/), the README.md you are reading now is copied to the image under path `/app/doc/README.md`.
2022-02-04|Simplified build process (not multistage anymore), reduced image sizes, documented the convenience build.sh script, corrected sourceforge tag names (were 1.9.8 or 1.8 instead of 1.9.9)
2022-02-02|Allow combination of presets, fixed incorrect mapping for SQUEEZELITE_DELAY, add 'extremus' upsample setting, defined rates presets
2022-01-30|Added images with SourceForge binaries (version 1.9.9), SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE renamed to SQUEEZELITE_BUFFER
