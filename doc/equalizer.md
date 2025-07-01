# Equalizer support

## References

Look at [this](https://forums.lyrion.org/forum/user-forums/general-discussion/1758009-sqeezebox-docker-configuration) thread for some context.  

## Example configuration

### Compose file

A simple compose file should look like the following:

```text
services:
  squeezelite:
    image: giof71/squeezelite:latest-alsa
    devices:
      - /dev/snd:/dev/snd
    environment:
      - USER_MODE=yes
      - PUID=1000
      - PGID=1000
      - AUDIO_GID=29
      - SQUEEZELITE_EQ_AUDIO_DEVICE=plughw:CARD=DAC,DEV=0
      - SQUEEZELITE_NAME=Aune X1S
      - SQUEEZELITE_MODEL_NAME=Aune X1S Manjaro i5
      - SQUEEZELITE_SERVER_PORT=${SQUEEZELITE_SERVER_PORT:-}
    restart: unless-stopped
```

There is no need to mount a custom file as `/etc/asound.conf`. The file is generated automatically.  
Tune the content of the variable `SQUEEZELITE_EQ_AUDIO_DEVICE` according to your audio device. Refer to the output of `aplay -l`.  
For PUID, PGID and AUDIO_GID, I am using typical values in my example. Again, this depends on your setup. Retrieve the id of the audio group using:

```text
getent group audio
```

Run the container as usual. In order to use the equalizer, run the following:

`docker-compose exec -u 1000 squeezelite alsamixer -D equal`
