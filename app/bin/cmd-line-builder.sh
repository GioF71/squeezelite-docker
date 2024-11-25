#!/bin/bash

DEFAULT_SQUEEZELITE_TIMEOUT=2
DEFAULT_SQUEEZELITE_DELAY=500

function quote_if_needed() {
    var="${1}"
    opt_quote="\""
    if [[ "${var}" = \"* ]]; then
        opt_quote=""
    fi
    echo "${opt_quote}${var}${opt_quote}"
}

function cmdline-server-port() {
    if [ -z "${SQUEEZELITE_SERVER_PORT}" ]; then
        echo "Variable SQUEEZELITE_SERVER_PORT has not been specified, using discovery"
    else
        echo "Variable SQUEEZELITE_SERVER_PORT has been specified: $SQUEEZELITE_SERVER_PORT"
        CMD_LINE="$CMD_LINE -s "$(quote_if_needed "${SQUEEZELITE_SERVER_PORT}")
    fi    
}

function cmdline-player-name() {
    if [ -z "${SQUEEZELITE_NAME}" ]; then
        echo "Variable SQUEEZELITE_NAME has not been specified"
    else
        echo "Variable SQUEEZELITE_NAME has been specified: ${SQUEEZELITE_NAME}"
        CMD_LINE="$CMD_LINE -n "$(quote_if_needed "${SQUEEZELITE_NAME}")
    fi
}

function cmdline-model-name() {
    if [ -z "${SQUEEZELITE_MODEL_NAME}" ]; then
      echo "Variable SQUEEZELITE_MODEL_NAME has not been specified"
    else
        echo "Variable SQUEEZELITE_MODEL_NAME has been specified: ${SQUEEZELITE_MODEL_NAME}"
        CMD_LINE="$CMD_LINE -M "$(quote_if_needed "${SQUEEZELITE_MODEL_NAME}")
    fi
}

function cmdline-timeout() {
    if [ -z "${SQUEEZELITE_TIMEOUT}" ]; then
        echo "Variable SQUEEZELITE_TIMEOUT has not been specified, using default ${DEFAULT_SQUEEZELITE_TIMEOUT}"
        SQUEEZELITE_TIMEOUT=${DEFAULT_SQUEEZELITE_TIMEOUT}
    else
        echo "Variable SQUEEZELITE_TIMEOUT has been specified: ${SQUEEZELITE_TIMEOUT}"
    fi
    CMD_LINE="$CMD_LINE -C "$(quote_if_needed "${SQUEEZELITE_TIMEOUT}")
}

function cmdline_mac_address() {
    if [ -z "${SQUEEZELITE_MAC_ADDRESS}" ]; then
        echo "Variable SQUEEZELITE_MAC_ADDRESS not specified"
    else
        echo "Variable SQUEEZELITE_MAC_ADDRESS specified: ${SQUEEZELITE_MAC_ADDRESS}"
        CMD_LINE="$CMD_LINE -m "$(quote_if_needed "${SQUEEZELITE_MAC_ADDRESS}")
    fi    
}

function cmdline-audio-device() {
    if [ -z "${SQUEEZELITE_AUDIO_DEVICE}" ]; then
        echo "Variable SQUEEZELITE_AUDIO_DEVICE has not been specified"
    else
        echo "Variable SQUEEZELITE_AUDIO_DEVICE has been specified: ${SQUEEZELITE_AUDIO_DEVICE}"
        CMD_LINE="$CMD_LINE -o "$(quote_if_needed "${SQUEEZELITE_AUDIO_DEVICE}")

    fi
}

function cmdline-mixer-device() {
    if [ -z "${SQUEEZELITE_MIXER_DEVICE}" ]; then
        echo "Variable SQUEEZELITE_MIXER_DEVICE has not been specified"
    else
        echo "Variable SQUEEZELITE_MIXER_DEVICE has been specified: ${SQUEEZELITE_MIXER_DEVICE}"
        CMD_LINE="$CMD_LINE -O "$(quote_if_needed "${SQUEEZELITE_MIXER_DEVICE}")
    fi
}

function cmdline-delay() {
    if [ -z "${SQUEEZELITE_DELAY}" ]; then
        echo "Variable SQUEEZELITE_DELAY has not been specified, using default ${DEFAULT_SQUEEZELITE_DELAY}"
        SQUEEZELITE_DELAY=${DEFAULT_SQUEEZELITE_DELAY}
    else
        echo "Variable SQUEEZELITE_DELAY has been specified: ${SQUEEZELITE_DELAY}"
    fi
    CMD_LINE="$CMD_LINE -D "$(quote_if_needed "${SQUEEZELITE_DELAY}")
}

function cmdline-params() {
    if [ -z "${SQUEEZELITE_PARAMS}" ]; then
        echo "Variable SQUEEZELITE_PARAMS has not been specified"
    else
        echo "Variable SQUEEZELITE_PARAMS has been specified: ${SQUEEZELITE_PARAMS}"
        CMD_LINE="$CMD_LINE -a "$(quote_if_needed "${SQUEEZELITE_PARAMS}")
    fi
}

function cmdline-volume-control() {
    if [ -z "${SQUEEZELITE_VOLUME_CONTROL}" ]; then
        echo "Variable SQUEEZELITE_VOLUME_CONTROL not specified"
    else
        echo "Variable SQUEEZELITE_VOLUME_CONTROL specified: ${SQUEEZELITE_VOLUME_CONTROL}"
        CMD_LINE="$CMD_LINE -V "$(quote_if_needed "${SQUEEZELITE_VOLUME_CONTROL}")
    fi
}

function cmdline-linear-volume() {
    if [ -z "${SQUEEZELITE_LINEAR_VOLUME}" ]; then
        echo "Variable SQUEEZELITE_LINEAR_VOLUME not specified"
    else
        echo "Variable SQUEEZELITE_LINEAR_VOLUME specified: ${SQUEEZELITE_LINEAR_VOLUME}"
        linear=${SQUEEZELITE_LINEAR_VOLUME^^}
        echo "linear: $linear"
        if [ "$linear" == "Y" ]; then
            echo "Variable SQUEEZELITE_LINEAR_VOLUME set to enabled."
            CMD_LINE="$CMD_LINE -X"
        else 
            if [ "$linear" == "N" ]; then
                echo "Variable SQUEEZELITE_LINEAR_VOLUME set to disabled."
            else
                echo "Variable SQUEEZELITE_LINEAR_VOLUME invalid value: ${SQUEEZELITE_LINEAR_VOLUME}"
            fi
        fi
    fi
}

function cmdline-codecs() {
    if [ -z "${SQUEEZELITE_CODECS}" ]; then
        echo "Variable SQUEEZELITE_CODECS has not been specified"
    else
        echo "Variable SQUEEZELITE_CODECS has been specified: ${SQUEEZELITE_CODECS}"
        CMD_LINE="$CMD_LINE -c "$(quote_if_needed "${SQUEEZELITE_CODECS}")
    fi
}

function cmdline-exclude-codecs() {
    if [ -z "${SQUEEZELITE_EXCLUDE_CODECS}" ]; then
        echo "Variable SQUEEZELITE_EXCLUDE_CODECS has not been specified"
    else
        echo "Variable SQUEEZELITE_EXCLUDE_CODECS has been specified: $SQUEEZELITE_EXCLUDE_CODECS"
        CMD_LINE="$CMD_LINE -e "$(quote_if_needed "${SQUEEZELITE_EXCLUDE_CODECS}")
    fi
}

function cmdline-rates() {
    if [ -z "${SQUEEZELITE_RATES}" ]; then
        echo "Variable SQUEEZELITE_RATES not specified"
    else
        echo "Variable SQUEEZELITE_RATES specified: ${SQUEEZELITE_RATES}"
        CMD_LINE="$CMD_LINE -r "$(quote_if_needed "${SQUEEZELITE_RATES}")
    fi
}

function cmdline-power-script() {
    if [ -z "${SQUEEZELITE_POWER_SCRIPT}" ]; then
        echo "Variable SQUEEZELITE_POWER_SCRIPT not specified"
    else
        # cannot combine with SQUEEZELITE_RPI_GPIO
        if [ -n "${SQUEEZELITE_RPI_GPIO}" ]; then
            echo "Cannot use SQUEEZELITE_POWER_SCRIPT along with SQUEEZELITE_RPI_GPIO"
            exit 1
        else
            echo "Variable SQUEEZELITE_POWER_SCRIPT specified: ${SQUEEZELITE_POWER_SCRIPT}"
            CMD_LINE="$CMD_LINE -S "$(quote_if_needed "${SQUEEZELITE_POWER_SCRIPT}")
        fi
    fi
}

function cmdline-rpi-gpio() {
    if [ -z "${SQUEEZELITE_RPI_GPIO}" ]; then
        echo "Variable SQUEEZELITE_RPI_GPIO not specified"
    else
        # cannot combine with SQUEEZELITE_RPI_GPIO
        if [ -n "${SQUEEZELITE_POWER_SCRIPT}" ]; then
            echo "Cannot use SQUEEZELITE_RPI_GPIO along with SQUEEZELITE_POWER_SCRIPT"
            exit 1
        else
            echo "Variable SQUEEZELITE_RPI_GPIO specified: ${SQUEEZELITE_RPI_GPIO}"
            CMD_LINE="$CMD_LINE -G "$(quote_if_needed "${SQUEEZELITE_RPI_GPIO}")
        fi
    fi
}

function handle_mac_address() {
    mac_gen_disabled=0
    if [[ "${DISABLE_MAC_ADDRESS_GENERATION^^}" == "YES" ]] || [[ "${DISABLE_MAC_ADDRESS_GENERATION^^}" == "Y" ]]; then
        mac_gen_disabled=1
    fi
    if [[ $mac_gen_disabled -eq 0 ]] && [[ -z "${SQUEEZELITE_MAC_ADDRESS}" ]]; then
        FILE_NAME=mac-address.txt
        if [[ -n "${CONFIG_FILE_PREFIX}" ]]; then
            FILE_NAME=${CONFIG_FILE_PREFIX}-${FILE_NAME}
        fi
        FILE_PATH="/config/${FILE_NAME}"
        echo "File name for mac-address is [$FILE_PATH]"
        echo "No mac address, specified, try loading ..."
        if [ -f $FILE_PATH ]; then
            echo "Found file with mac address ..."
            mac=`cat $FILE_PATH`
            echo "Mac address is ${mac}"
            SQUEEZELITE_MAC_ADDRESS="${mac}"
        else
            echo "Mac address not found, generating ..."
            for i in $(seq 1 6); do
                portion=$[RANDOM%10]$[RANDOM%10]
                if [ $i -eq 1 ]; then
                    mac="${portion}"
                else
                    mac="${mac}:${portion}"
                fi
            done
            echo "Generated mac address is [$mac]"
            SQUEEZELITE_MAC_ADDRESS="${mac}"
            # write if possible
            if [ -w /config ]; then
                echo "${mac}" > $FILE_PATH
                echo "Written generated [${mac}] mac address."
            else
                echo "Config directory is not writable"
            fi
        fi
    fi
}