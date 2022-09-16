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

#cat /etc/passwd

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

CMD_LINE="/usr/bin/squeezelite -o pulse"
echo "Initializing command line: ["$CMD_LINE"]"

if [ -z "${SQUEEZELITE_SERVER_PORT}" ]; then
  echo "Variable SQUEEZELITE_SERVER_PORT has not been specified, using discovery";
else
  echo "Variable SQUEEZELITE_SERVER_PORT has been specified: $SQUEEZELITE_SERVER_PORT";
  CMD_LINE="$CMD_LINE -s $SQUEEZELITE_SERVER_PORT";
fi

if [ -z "${SQUEEZELITE_NAME}" ]; then
  echo "Variable SQUEEZELITE_NAME has not been specified";
else
  echo "Variable SQUEEZELITE_NAME has been specified: $SQUEEZELITE_NAME";
  CMD_LINE="$CMD_LINE -n $SQUEEZELITE_NAME";
fi

echo "Command Line: ["$CMD_LINE"]"
#eval $CMD_LINE

#su - $USER_NAME -c "/usr/bin/squeezelite -n test-pulse -o pulse -s lms.homelab.com"
su - $USER_NAME -c "$CMD_LINE"

