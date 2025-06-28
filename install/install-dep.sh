#!/bin/bash

# exit codes
# 6 unsupported build type

invalid_combination=0

# Filter unnecessary builds
if [[ "${BINARY_MODE}" == "alsa-bt" ]]; then
    # no sf and no r2 for this build mode
    if [[ "${BUILD_MODE}" == "sf" ]] || [[ "${BUILD_MODE}" == "r2" ]]; then
        invalid_combination=1
    fi
fi

if [[ "${BUILD_MODE}" == "r2" ]]; then
    # only alsa for r2 build mode
    if [[ "${BINARY_MODE}" != "alsa" ]]; then
        invalid_combination=1
    fi
fi

if [ $invalid_combination -eq 1 ]; then
    echo "Invalid combination BUILD_MODE=[${BUILD_MODE}] BINARY_MODE=[${BINARY_MODE}]"
    exit 6
fi

if [[ "${BUILD_MODE}" == "sf" ]]; then
    echo "Using sourceforge binaries, installing required dependencies - BEGIN"
    apt-get update
    if [[ -z "${BINARY_MODE}" ]] || [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "alsa" ]]; then
        echo "Installing support for Alsa ..."
        apt-get install --no-install-recommends -y libasound2 libasound2-plugin-equal
        echo "Support for Alsa installed."
    fi
    if [[ -z "${BINARY_MODE}" ]] || [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "pulse" ]]; then
        echo "Installing support for PulseAudio ..."
        apt-get install --no-install-recommends -y \
            libavcodec59 \
            libavformat59 \
            libavutil57 \
            libfaad2 \
            libflac12 \
            liblirc-client0 \
            libmad0 \
            libmpg123-0 \
            libopusfile0 \
            libpulse0 \
            libsoxr0 \
            libssl3 \
            libvorbisfile3 \
            lsb-base
        echo "Support for PulseAudio installed."
    fi
    echo "Using sourceforge binaries, installing required dependencies - END"
elif [[ "${BUILD_MODE}" == "std" ]]; then
    echo "Using standard packages."
    if [[ "${BINARY_MODE}" == "alsa-bt" ]]; then
        echo "Installing packages for bluetooth ..."
        apt-get update
        apt-get install -y bluetooth bluez-alsa-utils alsa-utils
        echo "Finished installing packages for bluetooth ..."
    else
        echo "No additional packages to install."
    fi
elif [[ "${BUILD_MODE}" == "r2" ]]; then
    echo "Preparing for Squeezelite R2 (compiling)"
    apt-get update
    apt-get install -y \
        git \
        build-essential \
        libasound2 \
        libasound2-plugin-equal \
        libasound2-dev \
        libflac-dev \
        libmad0-dev \
        libfaad-dev \
        libmpg123-dev \
        libvorbis-dev
fi