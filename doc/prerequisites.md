# Prerequisites

You need to have Docker up and running on a Linux machine, and the current user must be allowed to run containers (this usually means that the current user belongs to the "docker" group).

You can verify whether your user belongs to the "docker" group with the following command:

`getent group | grep docker`

This command will output one line if the current user does belong to the "docker" group, otherwise there will be no output.

## Supported platforms

The Dockerfile and the included scripts have been tested on the following setups:

Hardware|Operating System|Result|Comment
:---|:---|:---|:---
Generic Amd64|Manjaro Gnome|OK|No issues encountered
Generic Amd64|Linux Mint 20.x|OK|No issues encountered
Raspberry Pi 3|Raspberry Pi OS 32bit/64bit, OSMC|OK|No issues encountered
Raspberry Pi 4|Raspberry Pi OS 32bit/64bit, OSMC, Manjaro KDE 64bit|OK|No issues encountered
Asus Tinkerboard|DietPi Bullseye, DietPi Bookworm|OK|Issues solved! See [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/asus-tinkerboard.md).

As I test the Dockerfile on more platforms, I will update this list.  

###Asus Tinkerboard

The issues I was encountered are solved now.  
See [here](https://github.com/GioF71/squeezelite-docker/blob/main/doc/asus-tinkerboard.md) for more information.

