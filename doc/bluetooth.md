# Bluetooth

Bluetooth will first need enabled on the host. 

## Requirements

- Bluetooth libraries
- Bluetooth device paired to host
- asound.conf mounted in /etc/asound.conf
- system_bus_socket mounted

### Bluetooth Libraries

You will need to install the following dependencies: `bluetooth bluez-alsa-utils alsa-utils`, or the equivalent in your distro. 

Example for debian:
`apt -y update && apt -y install bluetooth bluez-alsa-utils alsa-utils`

### Pairing device

Make sure your device has pairing enabled, then use `bluetoothctl scan on` until you see its MAC. If you do not know its MAC, look for its name or a name that looks like a speaker, or like the manufacturer's name. Note this down.

```
bluetoothctl trust YOUR_MAC
bluetoothctl pair YOUR_MAC
bluetoothctl connect YOUR_MAC
```
Replace `YOUR_MAC` with the speaker's MAC.

### Configuration file
To easily test and to actually use your bluetooth speaker inside the container you will need to make an asound configuration file. Here's a handy template:
```
pcm.!default {
    type plug
    slave {
        pcm {
            type bluealsa
            device YOUR_MAC
            profile "a2dp"
        }
    }
    hint {
        show on
        description "A_DESCRIPTION"
    }
 }
```
Replace `YOUR_MAC` and `A_DESCRIPTION` with the speaker's MAC and with any description you want, or remove the hint if you do not want a description.

To quickly test if it works, start bluealsa with
`bluealsa -p a2dp-source -p a2dp-sink --a2dp-volume &`
Then you can move this file to `~/.asoundrc` and use aplay normally
`aplay /path/to/your/file.wav`

## Auto-starting bluealsa 

Bluealsa needs to always run for this to work. The easiest way to assure this is to add the line to `/etc/rc.local` before `exit 0`. 

Example rc.local
```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi
bluealsa -p a2dp-source -p a2dp-sink --a2dp-volume &
exit 0
```

Then mount it inside your container, and use the special bluetooth image 
```

image: giof71/squeezelite:debian-alsa-bt-squeezelite-current
volumes:
      - /path/to/asound.conf:/etc/asound.conf:ro
      - /run/dbus/system_bus_socket:/run/dbus/system_bus_socket  
```
## Bonus: Auto-connecting the speaker on startup
Replace `YOUR_MAC_HERE` with the MAC of your bluetooth speakers. There's also commented out examples of how to add more speakers. On a Pi4B+ 3 speakers were successfully connected and playing different streams at once, though your mileage may vary.
```bash
#!/bin/bash
## Usage: bash speaker.sh <speaker> <action>
## Possible actions: connect, disconnect, remove  
## e.g: bash speaker.sh default connect
[[ -z $1 ]] && speaker=default || speaker=$1
[[ -z $2 ]] && action=connect || action=$2

case $speaker in
  default)
    MACs='YOUR_MAC_HERE' # 
  ;;
  ## Example to add another speaker 
  #livingroom)
  #  MACs='YOUR_MAC_HERE' # 
  #;;
  ## Example to add multiple speakers at once
  #both)
  #  MACs=('YOUR_MAC_HERE' 'YOUR_OTHER_MAC_HERE') # 
  #;;
esac

# Check bluetooth power
if ! bluetoothctl show | grep -q "Powered: yes"; then
    bluetoothctl power on
fi

# Check agent 
if ! bluetoothctl show | grep -q "Agent: on"; then
    bluetoothctl agent on
fi

for MAC in ${MACs[@]}; do
  case $action in
    connect)
      echo "Connecting to speaker $MAC!"
      if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
        echo "Speaker $speaker is already connected!"
        continue
      else
        bluetoothctl trust "$MAC"
        bluetoothctl pair "$MAC"
        bluetoothctl connect "$MAC"
      fi
    ;;
    disconnect)
      bluetoothctl disconnect "$MAC"
    ;;
    remove)
      bluetoothctl disconnect "$MAC"
      bluetoothctl untrust "$MAC"
      bluetoothctl remove "$MAC"
    ;;
  esac
done

```

