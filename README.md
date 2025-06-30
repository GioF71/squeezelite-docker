# squeezelite-docker

A Docker image for SqueezeLite  

- Support for upsampling
- Presets for improved convenience.  
- Multiplatform support thanks to [Der-Henning](https://github.com/Der-Henning/)
- Initial support for bluetooth, see [this discussion](https://github.com/GioF71/squeezelite-docker/discussions/242)

## Support

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/H2H7UIN5D)  
Please see the [Goal](https://ko-fi.com/giof71/goal?g=0).  
Please note that support goal is limited to cover running costs for subscriptions to music services.

## News

### Initial support for Bluetooth

Documentation available [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/bluetooth.md), thanks to [barrelltitor](https://github.com/barrelltitor).  
See [this discussion](https://github.com/GioF71/squeezelite-docker/discussions/242) for more details.  

### Squeezelite R2 variant

Since 2024-01-19 (see issue [#268](https://github.com/GioF71/squeezelite-docker/issues/268)) I am including builds for [Squeezelite R2](https://github.com/marcoc1712/squeezelite-R2), only in alsa mode.  
This patched version allows server-side transcoding, also to DSD format, which some users might like to use.  
These images will inclue `r2-latest-alsa` and `r2-stable-alsa` in their tags.  
Like to these type of images: [here](https://hub.docker.com/r/giof71/squeezelite/tags?page=1&name=r2).  
Since 2024-01-22 we have support for the `-W` command line argument on sourceforge alsa binaries using new variable `SQUEEZELITE_READ_FORMATS_FROM_HEADER`, while AFAIK this should be the default on the `r2` variant.    

### Alsa and PulseAudio variants

Since 2023-12-30 (see issue [#254](https://github.com/GioF71/squeezelite-docker/issues/254)) I am including separate builds for alsa and pulseaudio only. The [alsa sourceforge version](https://hub.docker.com/r/giof71/squeezelite/tags?page=1&name=debian-alsa-sourceforge) results in a particularily small image. Maybe the pulse version can be reduced in size, but I still need to perform a few tests in order to verify that I can remove some packages.  

## Available Archs on Docker Hub

- linux/amd64
- linux/arm64/v8
- linux/arm/v7
- linux/arm/v5

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

I prepared this Dockerfile Because I wanted to be able to install squeezelite easily on any machine (provided the architecture is amd64 or arm). Also I wanted to be able to configure and govern the parameters easily using environment variables.  
Configuring the container should be easy through a webapp like [Portainer](https://www.portainer.io/).

## Prerequisites

See [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/prerequisites.md) for the prerequisites.  

## Get the image

Here is the [repository](https://hub.docker.com/repository/docker/giof71/squeezelite) on DockerHub.

Getting the image from DockerHub is as simple as typing:

`docker pull giof71/squeezelite`

See [Docker Hub Tags](https://github.com/GioF71/squeezelite-docker/blob/main/README.md#docker-hub-tags) for more information about docker hub tags.

## Usage

You can start squeezelite by typing:

`docker run -d --rm --network host --device /dev/snd giof71/squeezelite`

Note that we need to allow the container to access the audio devices through /dev/snd.  
We also need to use the *host* network mode so the squeezelite instance can be discovered on your network.  
The host network mode is generally not necessary if you specify your server (and port) using the environment variable `SQUEEZELITE_SERVER_PORT`.

The following tables reports all the currently supported environment variables.

Variable|SqueezeLite corresponding option|Notes
:---|:---:|:---
SQUEEZELITE_MODE||Set to `ALSA` for alsa mode, or to `PULSE` for [PulseAudio](#pulseaudio) mode, defaults to `ALSA`
PUID||User ID which will be used to run squeezelite in user mode, defaults to `1000`
PGID||Group ID which will be used to run squeezelite in user mode, defaults to `1000`
AUDIO_GID||This group id is mandatory with alsa output when running in user mode. It must be set to the group id associated to the `audio` group. See more [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/example-alsa-user-mode.md).
PRESET||You can now choose to set variables using predefined presets. Presets can currently tune the values of `SQUEEZELITE_AUDIO_DEVICE`, `SQUEEZELITE_RATES`, `SQUEEZELITE_UPSAMPLING`, `SQUEEZELITE_CODECS` and `SQUEEZELITE_EXCLUDE_CODECS` for you. See the [Available presets](#available-presets) table for reference. Presets can be combined (the separator must be a comma `,`), but keep in mind that the first preset setting a variable has the priority: once set by a preset, a variable cannot be overwritten by subsequent presets.
SQUEEZELITE_EQ_AUDIO_DEVICE||The Audio device used for the custom asound file for equalizer. Use something like `plughw:DAC`, `plughw:0` depending on your hardware. Leave `SQUEEZELITE_AUDIO_DEVICE` blank or set it to `equal`
SQUEEZELITE_AUDIO_DEVICE|-o|The audio device. Common examples for alsa mode: `hw:CARD=x20,DEV=0` or `hw:CARD=DAC,DEV=0` for usb dac based on XMOS. If left empty, the default device is used.
SQUEEZELITE_MIXER_DEVICE|-O|Specify mixer device, defaults to `output device` (`SQUEEZELITE_AUDIO_DEVICE`)
SQUEEZELITE_PARAMS|-a|Please refer to the squeezelite's man page for `-a`.
SQUEEZELITE_CODECS|-c|Please refer to the squeezelite's man page for `-c`.
SQUEEZELITE_EXCLUDE_CODECS|-e|Please refer to the squeezelite's man page for `-e`.
SQUEEZELITE_PRIORITY|-p|Please refer to the squeezelite's man page for `-p`.
SQUEEZELITE_DELAY|-D|Set it to maybe something like `500,dop` if your DAC supports DoP. Defaults to `500`
SQUEEZELITE_NAME|-n|Name of the SqueezeLite player.
SQUEEZELITE_MODEL_NAME|-M|Name of the SqueezeLite model name.
SQUEEZELITE_MAC_ADDRESS|-m|Mac Address of the SqueezeLite player. The format must be colon-delimited hexadecimal, for example: `ab:cd:ef:12:34:56`. See note below.
DISABLE_MAC_ADDRESS_GENERATION||Disables automatic mac address generation and persistency
SQUEEZELITE_TIMEOUT|-C|Device timeout in seconds, defaults to `2`
SQUEEZELITE_SERVER_PORT|-s|Server and port of the server, for example: `squeezebox-server.local:3483` or `192.168.1.10:3483`. Do not specify the variable if you want to use the auto discovery feature. If you don't specify this variable, you will probably need to use host network mode. See the examples for some hints. The port can be omitted if not different from the default `3483`. So other possible valid values are `squeezebox-server.local` or `192.168.1.10`.
SQUEEZELITE_RATES|-r|From squeezelite's man page for `-r`: Specify sample rates supported by the output device; this is required if the output device is switched off when squeezelite is started. The format is either a single maximum sample rate, a range of sample rates in the format `<min>-<max>`, or a comma-separated list of available rates. Delay is an optional time to wait when switching sample rates between tracks, in milliseconds. Switch back to the author of this repository: it is recommended to specify sample rates that are effectively supported by your audio device.
SQUEEZELITE_UPSAMPLING|-u, -R|From squeezelite's man page for `-u`, same as `-R`: Enable upsampling of played audio. The argument is optional; see RESAMPLING for more information. The options `-u` and `-R` are synonymous.
SQUEEZELITE_BUFFER_SIZE|-b|From squeezelite's man page for `-b`: Specify internal stream and output buffer sizes in kilobytes. Default is 2048:3446.
DISPLAY_PRESETS||Set to `Y` if you want to see the presets on the container output
SQUEEZELITE_VOLUME_CONTROL|-V|From squeezelite's man page for `-V`: Use the given ALSA `control` for volume adjustment during playback. This prevents the use of software volume control within squeezelite. This option is mutually exclusive with the `-U` option. If neither `-U` nor `-V` options are provided, no ALSA controls are adjusted while running squeezelite and software volume control is used instead. Only applicable when using ALSA output.
SQUEEZELITE_UNMUTE|-U|From squeezelite's man page for `-U`: Unmute the given ALSA `control` at daemon startup and set it to full volume. Use software volume adjustment for playback. This option is mutually exclusive with the -V option. Only applicable when using ALSA output.
SQUEEZELITE_LINEAR_VOLUME|-X|Set to `Y` to enable. From squeezelite's man page for `-X`: Use linear volume adjustments instead of in terms of dB (only for hardware volume control).
SQUEEZELITE_VISUALIZER|-v|Set to `Y` to enable. Unfortunately this feature does not really work from inside docker (yet?). From squeezelite's man page for `-v`: Enable visualiser support.  This creates a shared memory segment that contains some of the audio being played, so that an external visualiser can read and process this to create visualisations.
SQUEEZELITE_READ_FORMATS_FROM_HEADER|-W|Set to `Y` to read wave and aiff format from header, ignoring server parameters
SQUEEZELITE_POWER_SCRIPT|-S|Absolute path to script to launch on power commands from LMS. This cannot be used in combination with the SQUEEZELITE_RPI_GPIO variable
SQUEEZELITE_RPI_GPIO|-G|Specify the BCM GPIO# to use for Amp Power Relay and if the output should be Active High or Low. This cannot be used in combination with SQUEEZELITE_POWER_SCRIPT
SELECT_CUSTOM_BINARY_ALSA||Use for selection of a custom binary for ALSA mode
SELECT_CUSTOM_BINARY_PULSE||Use for selection of a custom binary for PULSE mode
SQUEEZELITE_LOG_CATEGORY_ALL|-d|Support for log level on category `all`
SQUEEZELITE_LOG_CATEGORY_SLIMPROTO|-d|Support for log level on category `slimproto`
SQUEEZELITE_LOG_CATEGORY_STREAM|-d|Support for log level on category `stream`
SQUEEZELITE_LOG_CATEGORY_DECODE|-d|Support for log level on category `decode`
SQUEEZELITE_LOG_CATEGORY_OUTPUT|-d|Support for log level on category `output`
SQUEEZELITE_LOG_CATEGORY_IR|-d|Support for log level on category `ir`
CONFIG_FILE_PREFIX||Prefix for files in volume `/config`
INSTALL_BLUETOOTH_LIBRARIES||Install bluetooth libraries if set to `yes`
STARTUP_DELAY_SEC||Delay before starting the application, defaults to `0`

It is possible to add and additional preset configuration file using the volume `/app/assets/additional-presets.conf`.

### Possible values for Log Level configuration

Possible values for variables `SQUEEZELITE_LOG_CATEGORY_*` are `info`, `debug` or `sdebug`.

### Automatic MAC address creation

If you don't provide a value to `SQUEEZELITE_MAC_ADDRESS`, a random mac address will be generated and stored (if possible) under `/config/mac-address.txt`, so it will be reloaded on next restart. The file name can be prepended by the optional `CONFIG_FILE_PREFIX`.  
Use a persistent volume in order to preserve the functionality in the event of container recreation (such as when you update to a newer image).  
This feature can be disabled by setting `DISABLE_MAC_ADDRESS_GENERATION` to `yes`.  

## Volumes

Volume|Description
:---|:---
/app/assets/additional-presets.conf|Additional preset file
/app/assets/binaries|Custom binaries should be placed here
/config|Container configuration will be stored here

### Additional preset file

A preset file is a text file with a pair `key=value` on each line.
You can specify `.device`, `.upsampling`, `.rates`, `.codecs`, `.exclude-codecs` for each preset.
Just check `/app/assets/builtin-presets.conf` to understand how to create the other presets you might want to add.
Blank lines are allowed, as well as commented lines.

For example, the following file defines a preset named `my-usb-dac` for a specific dac:

```text
# my own usb dac
my-usb-dac.device="hw:CARD=my-dac,DEV=0"
```

### Example docker-compose with an additional preset file

See a docker-compose example using an additional preset file. The example assumes that the additional preset file is `./config/additional.conf`.
The additional preset file is used in combination with other presets for [upsampling](#upsampling) using the goldilocks settings: `archimago-goldilocks` and `rates_up_to_384k`:

```code
---
version: "3"

services:
  squeezelite-my-usb-dac:
    image: giof71/squeezelite
    container_name: squeezelite-my.usb-dac
    devices:
      - /dev/snd:/dev/snd
    environment:
      - PRESET=my-usb-dac,archimago-goldilocks,rates_up_to_384k
      - SQUEEZELITE_NAME=my-usb-dac
      - SQUEEZELITE_SERVER_PORT=192.168.1.10
      - DISPLAY_PRESETS=Y
    volumes:
      - ./config/additional.conf:/app/assets/additional-presets.conf
    restart: unless-stopped
```

See the [Available presets](#available-presets) table for reference.

## Upsampling

In case you want to apply the [Archimago's Goldilocks](https://archimago.blogspot.com/2018/01/musings-more-fun-with-digital-filters.html) suggestion, the variables should be set as in the following table. Refer to the line which resembles the capabilities of your audio device.

Variable|Audio Device Capabilities|Suggested value
:---|:---:|:---
SQUEEZELITE_RATES|All sampling rates up to 384kHz|44100-384000
SQUEEZELITE_RATES|All sampling rates up to 192kHz|44100-192000
SQUEEZELITE_RATES|All sampling rates up to 96kHz|44100-96000
SQUEEZELITE_RATES|Typical USB Class 1 (88.2kHz is sometimes not supported, so we upsample to 96k)|96000
SQUEEZELITE_UPSAMPLING|Anything higher than 44.1kHz|v::4:28:95:105:45

The `SQUEEZELITE_RATES` displayed here are provided just as an example. You still should verify the capabilities of your particular audio device.

## Available presets

Preset name|Availability date|Set Properties|Comment
:---|:---:|:---:|:---
topping-d10-balanced|2023-09-23|Device|Sets device for Topping D10 Balanced
topping-d10s|2023-09-23|Device|Sets device for Topping D10s
gustard-12|2022-09-28|Device|Sets device for Gustard U12 DDC
yulong-d200|2022-09-27|Device|Sets device for Yulong D200 (updated 2023-09-23)
aune-s6|2022-09-27|Device|Sets device for Aune S6
aune-x1s|2022-09-27|Device|Sets device for Aune X1S
peachtree-dacit|2022-09-27|Device|Sets device for Peachtree DAC-iT
gustard-x16|2022-06-10|Device|Sets device for Gustard X16
topping-dx5|2022-06-10|Device|Sets device for Topping DX5
pi-headphones|2022-02-19|Device|Sets device for Raspberry Pi Headphone out
dac|2022-02-02|Device|Sets device for typical xmos dac named "DAC"
x20|2022-02-02|Device|Sets device for typical xmos dac named "x20"
topping-d10|2022-02-02|Device|Sets device for Topping D10
gustard-x12|2022-02-02|Device|Sets device for Gustard X12
hifiberry-dac-plus|2022-02-02|Device|Sets device for the HifiBerry Dac+
ifi-zen-dac|2022-02-16|Device|Sets device for the Ifi Zen Dac
fiio-e18|2022-02-16|Device|Sets device for Fiio E18
goldilocks|2022-01-19|Upsampling|Setup goldilocks upsampling for usb dac, rates must be set with another preset or explicitly using the variable `SQUEEZELITE_RATES`. Corresponds to `v::4:28:95:105:45`
extremus|2022-01-19|Upsampling|Setup [extremus](https://archimago.blogspot.com/2018/11/musings-raspberry-pi-3-b-touch.html) upsampling for usb dac, rates must be set with another preset or explicitly using the variable `SQUEEZELITE_RATES`. Corresponds to `v::3.05:28:99.7:100:45`
archimago-goldilocks|2022-02-04|Upsampling|Alias for `goldilocks`, name feels more appropriate
archimago-extremus|2022-02-04|Upsampling|Alias for `extremus`, name feels more appropriate
rates_up_to_96k|2022-02-02|Rates|Set rates to `44100-96000`
rates_up_to_192k|2022-02-02|Rates|Set rates to `44100-192000`
rates_up_to_384k|2022-02-02|Rates|Set rates to `44100-384000`
rates_up_to_768k|2022-02-02|Rates|Set rates to `44100-768000`
rates_2x_only|2022-02-02|Rates|Set rates to `88200,96000`
rates_4x_only|2022-02-02|Rates|Set rates to `176400,192000`
rates_8x_only|2022-02-02|Rates|Set rates to `352800,384000`
rates_16x_only|2022-02-02|Rates|Set rates to `705600,768000`
goldilocks_up_to_96k|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, up to 96kHz
goldilocks_up_to_192k|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, up to 192kHz
goldilocks_up_to_384k|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, up to 384kHz
goldilocks_up_to_768k|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, up to 768kHz
goldilocks_2x_only|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, along with 2x rates only
goldilocks_4x_only|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, along with 4x rates only
goldilocks_8x_only|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, along with 8x rates only
goldilocks_16x_only|2022-01-19|Rates, Upsampling|Setup goldilocks upsampling for usb dac, along with 16x rates only
gustard-x12-goldilocks|2022-01-19|Device, Rates, Upsampling|Setup goldilocks upsampling for usb dac, up to 384kHz, and also sets output device correctly for a Gustard X12 DAC
no-dsd|2022-02-14|Excluded Codecs|Exclude dsd codec

## PulseAudio

You can specify PulseAudio mode by setting the environment variable `SQUEEZELITE_MODE` to `PULSE`.
For that configuration to work properly, `/run/user/1000/pulse` must be mapped correctly. It is not mandatory to use `1000`: if you set `PUID` to `1002` for instance, the right part of the volume mount should be `/run/user/1002/pulse`.  
The example below assumes that your current user id is `1000`. You might want to set the `PUID` and `PGID` variables according to your user and groupid. Use the `id` command to see the uid for the currently logged in user.  
Mapping the device `/dev/snd` is not needed in PulseAudio mode.  
Most of the enviroment variables are available in PulseAudio mode, unless irrelevant or incompatible.

```code
---
version: "3"

services:
  sq-pulse:
    image: giof71/squeezelite
    container_name: sq-pulse
    volumes:
      # change only on the left side according to your uid
      - /run/user/1000/pulse:/run/user/1000/pulse
    environment:
      - SQUEEZELITE_MODE=PULSE
      - PUID=1000 #optional, default is 1000
      - PGID=1000 #optional, default is 1000
      - SQUEEZELITE_NAME=sq-pulse #optional
      - SQUEEZELITE_SERVER_PORT=192.168.1.10 #optional
```

I would avoid to add a restart strategy to the compose file with PulseAudio. On my desktop setup, doing so led to all sort of issues on computer startup/reboot. Instead, I would use a user-level systemd service. An example is container in the `pulse` directory of this repository.
Remember to use host networking if you need the player to be automatically discovered. Also, when using a docker run command and not using host mode, I'd suggest to create a dedicated network. This should be covered by the service in the `pulse` directory.

The `buster` build without sourceforge binaries has been since dropped, because the squeezelite-pulseaudio package is not available.

## Multiple Configurations on the same dac, and multi-dac configurations

I am using the same host and I am connecting two dacs. I (generally) do not play music on multiple DACs at the same time, but I like to have multiple configurations a click away from the Logitech Media Server web interface.
If you are interested, have a look at the following sample `docker-compose.yaml` files:

Scenario|Link to config file
:---|:---
One DAC, multiple configurations|[single-dac-multi-config-docker-compose.yaml](https://gist.github.com/GioF71/41c3f5e3c99af6f1ec9472c0b15944b0)
Two DACs, multiple configurations|[dual-dac-multi-config-docker-compose.yaml](https://gist.github.com/GioF71/3b5906bc2da1ea291d33fd36b6a3f636)

Remember to always specify the SQUEEZELITE_SERVER_PORT for these compose files, otherwise the player discovery on Logitech Media Server with not be able to find all the configured players.

## Configuration changes

See [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/config-changes.md).

## A few examples

As contributed by [vespadj](https://github.com/vespadj) in [Issue #6](https://github.com/GioF71/squeezelite-docker/issues/6), have a look at this simple `docker-compose` service for the Raspberry Pi using its onboard headphone jack as the output device (I only added host network mode so the player is discoverable):

```text
---
version: "3.3"

services:
  squeezelite:
    image: giof71/squeezelite
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

Please note that `STARTUP_DELAY_SEC` is optional.
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
    giof71/squeezelite
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
  squeezelite-hifiberry:
    image: giof71/squeezelite
    container_name: squeezelite-hifiberry
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
    image: giof71/squeezelite
    container_name: squeezelite-gustard-x12
    devices:
      - /dev/snd:/dev/snd
    environment:
      - PRESET=gustard-x12,goldilocks,rates_up_to_384k
      - SQUEEZELITE_NAME=gustard-x12-usb
      - SQUEEZELITE_SERVER_PORT="192.168.1.10"
    restart: unless-stopped
```

## Build

See build instructions [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/build.md).

## Docker Hub tags

From this repository I create all the versions of the image. Each of them feature different base images and different way to obtain the squeezelite binary. See the following table for the details.

Tag|Base Image|SqueezeLite Version|SqueezeLite Origin|Additional Tags
:---|:---:|:---:|:---:|:---
debian|debian:stable-slim|1.9.9|Debian Repo|latest, stable, debian-squeezelite-1.9.9, debian-squeezelite-1.9.9-RELEASE
debian-sourceforge|debian:stable-slim|current|SourceForge|sourceforge-latest, sourceforge-stable, debian-squeezelite-current-sourceforge, debian-squeezelite-current-sourceforge-RELEASE

## Release History

The change log is available [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/release.md).
