#!/bin/bash

if [[ "$DOWNLOAD_FROM_SOURCEFORGE" == "Y" ]]; then
    echo "Using sourceforge binaries, installing required dependencies - BEGIN"
    apt-get update
    if [[ -z "${BUILD_MODE^^}" ]] || [[ "${BUILD_MODE^^}" == "FULL" ]] || [[ "${BUILD_MODE^^}" == "ALSA" ]]; then
        echo "Installing support for Alsa ..."
        apt-get install --no-install-recommends -y libasound2
        echo "Support for Alsa installed."
    fi
    if [[ -z "${BUILD_MODE^^}" ]] || [[ "${BUILD_MODE^^}" == "FULL" ]] || [[ "${BUILD_MODE^^}" == "PULSE" ]]; then
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
fi
