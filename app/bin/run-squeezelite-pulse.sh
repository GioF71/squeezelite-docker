#!/bin/bash

echo "Running in pulse mode"

DEFAULT_UID=1000
DEFAULT_GID=1000

if [ -z "${PUID}" ]; then
  PUID=$DEFAULT_UID;
  echo "Setting default value for PUID: ["$PUID"]"
fi

if [ -z "${PGID}" ]; then
  PGID=$DEFAULT_GID;
  echo "Setting default value for PGID: ["$PGID"]"
fi

USER_NAME=sq-pulse
GROUP_NAME=sq-pulse

HOME_DIR=/home/$USER_NAME

### create home directory and ancillary directories
if [ ! -d "$HOME_DIR" ]; then
  echo "Home directory [$HOME_DIR] not found, creating."
  mkdir -p $HOME_DIR
  chown -R $PUID:$PGID $HOME_DIR
  ls -la $HOME_DIR -d
  ls -la $HOME_DIR
fi

### create group
if [ ! $(getent group $GROUP_NAME) ]; then
  echo "group $GROUP_NAME does not exist, creating..."
  groupadd -g $PGID $GROUP_NAME
else
  echo "group $GROUP_NAME already exists."
fi

### create user
if [ ! $(getent passwd $USER_NAME) ]; then
  echo "user $USER_NAME does not exist, creating..."
  useradd -g $PGID -u $PUID -s /bin/bash -M -d $HOME_DIR $USER_NAME
  usermod -a -G audio $USER_NAME
  id $USER_NAME
  echo "user $USER_NAME created."
else
  echo "user $USER_NAME already exists."
fi

PULSE_CLIENT_CONF="/etc/pulse/client.conf"

echo "cat /app/assets/pulse-client-template.conf"
cat /app/assets/pulse-client-template.conf

echo "Creating pulseaudio configuration file $PULSE_CLIENT_CONF..."
cp /app/assets/pulse-client-template.conf $PULSE_CLIENT_CONF
sed -i 's/PUID/'"$PUID"'/g' $PULSE_CLIENT_CONF
cat $PULSE_CLIENT_CONF

CMD_LINE="/app/bin/squeezelite-pulseaudio"
echo "Initializing command line: ["$CMD_LINE"]"

source cmd-line-builder.sh

cmdline-server-port
cmdline-player-name
cmdline-model-name
cmdline-timeout
cmdline-mac-address

source logging.sh

add_log_categories

echo "Command Line: ["$CMD_LINE"]"

su - $USER_NAME -c "$CMD_LINE"

