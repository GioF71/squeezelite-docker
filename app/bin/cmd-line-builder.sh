#!/bin/bash

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
