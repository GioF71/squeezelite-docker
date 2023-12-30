#!/bin/bash

apt-get update

if [[ -z "${BUILD_MODE^^}" ]] || [[ "${BUILD_MODE^^}" == "FULL" ]] || [[ "${BUILD_MODE^^}" == "ALSA" ]]; then
    echo "Installing support for Alsa ..."
    apt-get install libasound2 --no-install-recommends -y
    echo "Support for Alsa installed."
fi
if [[ -z "${BUILD_MODE^^}" ]] || [[ "${BUILD_MODE^^}" == "FULL" ]] || [[ "${BUILD_MODE^^}" == "PULSE" ]]; then
    echo "Installing support for PulseAudio ..."
    apt-get install pulseaudio --no-install-recommends -y
    echo "Support for PulseAudio installed."
fi
