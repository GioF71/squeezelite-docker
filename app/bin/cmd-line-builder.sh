#!/bin/bash

DEFAULT_SQUEEZELITE_TIMEOUT=2
DEFAULT_SQUEEZELITE_DELAY=500

function cmdline-server-port() {
    if [ -z "${SQUEEZELITE_SERVER_PORT}" ]; then
        echo "Variable SQUEEZELITE_SERVER_PORT has not been specified, using discovery";
    else
        echo "Variable SQUEEZELITE_SERVER_PORT has been specified: $SQUEEZELITE_SERVER_PORT";
        CMD_LINE="$CMD_LINE -s $SQUEEZELITE_SERVER_PORT";
    fi    
}

function cmdline-player-name() {
    if [ -z "${SQUEEZELITE_NAME}" ]; then
        echo "Variable SQUEEZELITE_NAME has not been specified";
    else
        echo "Variable SQUEEZELITE_NAME has been specified: $SQUEEZELITE_NAME";
        CMD_LINE="$CMD_LINE -n $SQUEEZELITE_NAME";
    fi
}

function cmdline-model-name() {
    if [ -z "${SQUEEZELITE_MODEL_NAME}" ]; then
      echo "Variable SQUEEZELITE_MODEL_NAME has not been specified";
    else
        echo "Variable SQUEEZELITE_MODEL_NAME has been specified: $SQUEEZELITE_MODEL_NAME";
        CMD_LINE="$CMD_LINE -M $SQUEEZELITE_MODEL_NAME";
    fi
}

function cmdline-timeout() {
    if [ -z "${SQUEEZELITE_TIMEOUT}" ]; then
        echo "Variable SQUEEZELITE_TIMEOUT has not been specified, using default $DEFAULT_SQUEEZELITE_TIMEOUT";
        SQUEEZELITE_TIMEOUT=$DEFAULT_SQUEEZELITE_TIMEOUT;
    else
        echo "Variable SQUEEZELITE_TIMEOUT has been specified: $SQUEEZELITE_TIMEOUT";
    fi
    CMD_LINE="$CMD_LINE -C $SQUEEZELITE_TIMEOUT";
}

function cmdline-mac-address() {
    if [ -z "${SQUEEZELITE_MAC_ADDRESS}" ]; then
        echo "Variable SQUEEZELITE_MAC_ADDRESS not specified";
    else
        echo "Variable SQUEEZELITE_MAC_ADDRESS specified: $SQUEEZELITE_MAC_ADDRESS";
        CMD_LINE="$CMD_LINE -m $SQUEEZELITE_MAC_ADDRESS";
    fi    
}

function cmdline-audio-device() {
    if [ -z "${SQUEEZELITE_AUDIO_DEVICE}" ]; then
        echo "Variable SQUEEZELITE_AUDIO_DEVICE has not been specified";
    else
        echo "Variable SQUEEZELITE_AUDIO_DEVICE has been specified: $SQUEEZELITE_AUDIO_DEVICE";
        CMD_LINE="$CMD_LINE -o "$SQUEEZELITE_AUDIO_DEVICE;
    fi
}

function cmdline-mixer-device() {
    if [ -z "${SQUEEZELITE_MIXER_DEVICE}" ]; then
        echo "Variable SQUEEZELITE_MIXER_DEVICE has not been specified";
    else
        echo "Variable SQUEEZELITE_MIXER_DEVICE has been specified: $SQUEEZELITE_MIXER_DEVICE";
        CMD_LINE="$CMD_LINE -O $SQUEEZELITE_MIXER_DEVICE";
    fi
}

function cmdline-delay() {
    if [ -z "${SQUEEZELITE_DELAY}" ]; then
        echo "Variable SQUEEZELITE_DELAY has not been specified, using default $DEFAULT_SQUEEZELITE_DELAY";
        SQUEEZELITE_DELAY=$DEFAULT_SQUEEZELITE_DELAY;
    else
        echo "Variable SQUEEZELITE_DELAY has been specified: $SQUEEZELITE_DELAY";
    fi
    CMD_LINE="$CMD_LINE -D $SQUEEZELITE_DELAY";
}