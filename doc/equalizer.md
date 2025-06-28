# Equalizer support

## References

Look at [this](https://forums.lyrion.org/forum/user-forums/general-discussion/1758009-sqeezebox-docker-configuration) thread for some context.  

## Example configuration

### Custom asound.conf file

Create a file (it's not required it to be at /etc/asound.conf), similar to the following:

```text
ctl.equal {
    type equal;
}
 
pcm.plugequal {
    type equal;
    slave.pcm "plughw:DAC";
}
 
pcm.equal {
    type plug;
    slave.pcm plugequal;
}
```

Replace the line that says `slave.pcm "plughw:DAC"` with your dac information. You might need to set something like `slave.pcm "plughw:0"`, `slave.pcm "plughw:1,0"`. YMMV.  
Save the file as (e.g.) eq-asound.conf in the same directory where you are going to save your docker-compose.yaml file.

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
      - SQUEEZELITE_AUDIO_DEVICE=equal
      - SQUEEZELITE_NAME=Aune X1S
      - SQUEEZELITE_MODEL_NAME=Aune X1S Manjaro i5
      - SQUEEZELITE_SERVER_PORT=${SQUEEZELITE_SERVER_PORT:-}
    volumes:
      - ./eq-asound.conf:/etc/asound.conf:ro
    restart: unless-stopped
```

I am using the typical values for PUID, PGID and AUDIO_GID. Again, this depends on your setup. Retrieve the id of the audio group using:

```text
getent group audio
```

Run the container as usual. In order to use the equalizer, run the following:

`docker-compose exec -u 1000 squeezelite alsamixer -D equal`
