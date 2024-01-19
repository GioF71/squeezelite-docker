#!/bin/bash

if [[ "$BUILD_MODE" == "sf" ]]; then
    echo "Using sourceforge binaries, installing required dependencies - BEGIN"
    apt-get update
    if [[ -z "${BINARY_MODE^^}" ]] || [[ "${BINARY_MODE^^}" == "FULL" ]] || [[ "${BINARY_MODE^^}" == "ALSA" ]]; then
        echo "Installing support for Alsa ..."
        apt-get install --no-install-recommends -y libasound2
        echo "Support for Alsa installed."
    fi
    if [[ -z "${BINARY_MODE^^}" ]] || [[ "${BINARY_MODE^^}" == "FULL" ]] || [[ "${BINARY_MODE^^}" == "PULSE" ]]; then
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
elif [[ "$BUILD_MODE" == "std" ]]; then
    echo "Using standard packages, no additional dependencies required."
elif [[ "$BUILD_MODE" == "r2" ]]; then
    echo "Preparing for Squeezelite R2 (compiling)"
    apt-get update
    apt-get install -y \
        git \
        build-essential \
        libasound2 \
        libasound2-dev \
        libflac-dev \
        libmad0-dev \
        libfaad-dev \
        libmpg123-dev \
        libvorbis-dev
fi