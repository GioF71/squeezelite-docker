# Alsa output in user mode

## Using environment variables

Is it now possible to require squeezelite-docker to run `squeezelite` as a specific user. However, it is important to specify the AUDIO_GID variable to the `audio` group. For one of my system, this gid is `995`. See [here](#retrieve-the-audio-group-id) for more information on how to retrieve this group id.  
Here is the docker-compose file for my gustard x12 DAC, provided as an example:

```text
---
version: "3"

services:
  squeezelite-x12:
    image: giof71/squeezelite
    container_name: squeezelite-x12
    devices:
      - /dev/snd:/dev/snd
    environment:
      - USER_MODE=Y
      - PUID=1000
      - PGID=1000
      - AUDIO_GID=995
      - PRESET=gustard-x12,archimago-goldilocks,rates_up_to_384k
      - SQUEEZELITE_NAME=gustard-x12-usb
      - SQUEEZELITE_SERVER_PORT=lms.homelab.local
```

## Using docker user mode

You can also require docker to run the container in user mode: you will need to specify `user` in the compose file.  
As mentioned before, you will need to [specify the appropriate gid](#retrieve-the-audio-group-id) otherwise you won't get audio working.  
See the following example:

```text
---
version: "3"

services:
  squeezelite-x12:
    image: giof71/squeezelite
    container_name: squeezelite-x12
    devices:
      - /dev/snd:/dev/snd
    user: 1000:995
    environment:
      - PRESET=gustard-x12,archimago-goldilocks,rates_up_to_384k
      - SQUEEZELITE_NAME=gustard-x12-usb
      - SQUEEZELITE_SERVER_PORT=lms.homelab.local
```

As a sidenote, the container will show a warning:

```text
squeezelite-x12  | Failed to create secure directory (//.config/pulse): No such file or directory
```

which seems to be harmless.

## Retrieve the audio group id

You can retrieve the group id associated to the `audio` group with the following command:

```code
getent group audio
```

On my system, this commands outputs:

```text
audio:x:995:brltty,mpd,squeezelite
```

So `995` in my case is the value to be used for the `AUDIO_GID` variable or for the group id in the `user` line of the docker-compose file.
