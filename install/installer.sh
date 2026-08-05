#!/bin/bash

set -ex

# Error codes
# 1 Unsupported platform
# 2 Invalid argument

ARCH=`uname -m`
echo "ARCH=[${ARCH}] FORCE_ARCH=[${FORCE_ARCH}]"
if [[ -n "${FORCE_ARCH}" ]]; then
    echo "Overriding ARCH=[${ARCH}] to [${FORCE_ARCH}]"
    ARCH="${FORCE_ARCH}"
fi

echo "install-script.sh: BINARY_MODE=[${BINARY_MODE}]"
echo "install-script.sh: BUILD_MODE=[${BUILD_MODE}]"
echo "install-script.sh: ARCH=[${ARCH}]"

OUTPUT_FILE=/app/bin/squeezelite
OUTPUT_FILE_PULSE=/app/bin/squeezelite-pulseaudio

BINARY_MODE_FULL="full"
BINARY_MODE_ALSA="alsa"
BINARY_MODE_PULSE="pulse"
BINARY_MODE_ALSA_BT="alsa-bt"

BUILD_MODE_STD="std"
BUILD_MODE_SOURCEFORGE="sf"
BUILD_MODE_SOURCEFORGE_FFMPEG="sf-ffmpeg"
BUILD_MODE_R2="r2"

arch_amd64=x86_64
arch_arm_v7=armv7l
arch_arm_v8=aarch64

declare -A sf_alsa_file_dict
sf_alsa_file_dict[$arch_amd64]="squeezelite-2.0.0.1584-x86_64.tar.gz"
sf_alsa_file_dict[$arch_arm_v8]="squeezelite-2.0.0.1584-aarch64.tar.gz"
sf_alsa_file_dict[$arch_arm_v7]="squeezelite-2.0.0.1584-armhf.tar.gz"

declare -A sf_ffmpeg_alsa_file_dict
sf_ffmpeg_alsa_file_dict[$arch_amd64]="squeezelite-ffmpeg-2.0.0.1584-x86_64.tar.gz"
sf_ffmpeg_alsa_file_dict[$arch_arm_v8]="squeezelite-ffmpeg-2.0.0.1584-aarch64.tar.gz"
sf_ffmpeg_alsa_file_dict[$arch_arm_v7]="squeezelite-ffmpeg-2.0.0.1584-armhf.tar.gz"

declare -A sf_pulse_file_dict
sf_pulse_file_dict[$arch_amd64]="squeezelite-pulse-2.0.0.1584-x86_64.tar.gz"
sf_pulse_file_dict[$arch_arm_v8]="squeezelite-pulse-2.0.0.1584-aarch64.tar.gz"

declare -A sf_ffmpeg_pulse_file_dict
sf_ffmpeg_pulse_file_dict[$arch_amd64]="squeezelite-ffmpeg-pulse-2.0.0.1584-x86_64.tar.gz"
sf_ffmpeg_pulse_file_dict[$arch_arm_v8]="squeezelite-ffmpeg-pulse-2.0.0.1584-aarch64.tar.gz"

if [[ "${BUILD_MODE}" == "${BUILD_MODE_SOURCEFORGE}" ]]; then
    if [[ "${BINARY_MODE}" == "${BINARY_MODE_FULL}" ]] || [[ "${BINARY_MODE}" == "${BINARY_MODE_ALSA}" ]]; then
        SL_ALSA_FILENAME=${sf_alsa_file_dict["${ARCH}"]};
        if [[ -n "${SL_ALSA_FILENAME}" ]]; then
            echo "Found Alsa version for architecture ${ARCH}, decompressing ..."
            mkdir -p /app/assets/sourceforge/expanded
            tar xzvf "/app/assets/sourceforge/${SL_ALSA_FILENAME}" -C /app/assets/sourceforge/expanded
            ls -la /app/assets/sourceforge/expanded/
            mv /app/assets/sourceforge/expanded/squeezelite $OUTPUT_FILE
        else
            echo "NOT Found Alsa version for architecture ${ARCH}, exiting!"
            exit 1
        fi
    fi
    if [[ "${BINARY_MODE}" == "${BINARY_MODE_FULL}" ]] || [[ "${BINARY_MODE}" == "${BINARY_MODE_PULSE}" ]]; then
        SL_PULSE_FILENAME=${sf_pulse_file_dict["${ARCH}"]};
        if [[ -n "${SL_PULSE_FILENAME}" ]]; then
            echo "Found PulseAudio version for architecture ${ARCH}, decompressing ..."
            mkdir -p /app/assets/sourceforge/expanded-pulse
            tar xzvf "/app/assets/sourceforge/${SL_PULSE_FILENAME}" -C /app/assets/sourceforge/expanded-pulse
            ls -la /app/assets/sourceforge/expanded-pulse/
            mv /app/assets/sourceforge/expanded-pulse/squeezelite $OUTPUT_FILE_PULSE
        else
            echo "NOT Found PulseAudio version for architecture ${ARCH}, exiting!"
            exit 1
        fi
    fi
    # cleanup
    apt-get autoremove -y
    rm -Rf /assets
elif [[ "${BUILD_MODE}" == "${BUILD_MODE_SOURCEFORGE_FFMPEG}" ]]; then
    if [[ "${BINARY_MODE}" == "${BINARY_MODE_ALSA}" ]]; then
        SL_FFMPEG_ALSA_FILENAME=${sf_ffmpeg_alsa_file_dict["${ARCH}"]};
        if [[ -n "${SL_FFMPEG_ALSA_FILENAME}" ]]; then
            echo "Found FFMPEG Alsa version for architecture ${ARCH}, decompressing ..."
            mkdir -p /app/assets/sourceforge/expanded
            tar xzvf "/app/assets/sourceforge/${SL_FFMPEG_ALSA_FILENAME}" -C /app/assets/sourceforge/expanded
            ls -la /app/assets/sourceforge/expanded/
            mv /app/assets/sourceforge/expanded/squeezelite $OUTPUT_FILE
        else
            echo "NOT Found FFMPEG Alsa version for architecture ${ARCH}, exiting!"
            exit 1
        fi
    fi
    if [[ "${BINARY_MODE}" == "${BINARY_MODE_PULSE}" ]]; then
        SL_FFMPEG_PULSE_FILENAME=${sf_ffmpeg_pulse_file_dict["${ARCH}"]};
        if [[ -n "${SL_FFMPEG_PULSE_FILENAME}" ]]; then
            echo "Found FFMPEG PulseAudio version for architecture ${ARCH}, decompressing ..."
            mkdir -p /app/assets/sourceforge/expanded-pulse
            tar xzvf "/app/assets/sourceforge/${SL_FFMPEG_PULSE_FILENAME}" -C /app/assets/sourceforge/expanded-pulse
            ls -la /app/assets/sourceforge/expanded-pulse/
            mv /app/assets/sourceforge/expanded-pulse/squeezelite $OUTPUT_FILE_PULSE
        else
            echo "NOT Found PulseAudio version for architecture ${ARCH}, exiting!"
            exit 1
        fi
    fi
    # cleanup
    apt-get autoremove -y
    rm -Rf /assets
elif [[ "${BUILD_MODE}" == "${BUILD_MODE_R2}" ]]; then
    echo "Building squeezelite r2 ..."
    mkdir -p /app/r2-src
    cd /app/r2-src
    git clone https://github.com/marcoc1712/squeezelite-R2.git
    cd squeezelite-R2
    make -f Makefile.debian
    mv squeezelite-R2-deb /app/bin/squeezelite
    chmod 755 /app/bin/squeezelite
    cd /app
    rm -Rf /app/r2-src
elif [[ "${BUILD_MODE}" == "${BUILD_MODE_STD}" ]]; then
    if [[ "${BINARY_MODE}" == "${BINARY_MODE_FULL}" ]] || [[ "${BINARY_MODE}" == "${BINARY_MODE_ALSA}" ]] || [[ "${BINARY_MODE}" == "${BINARY_MODE_ALSA_BT}" ]]; then
        echo "Installing ALSA ..."
        apt-get update
        apt-get install squeezelite --no-install-recommends -y
        cp /usr/bin/squeezelite /app/bin/squeezelite
        echo "Installed ALSA."
    fi
    if [[ "${BINARY_MODE}" == "${BINARY_MODE_FULL}" ]] || [[ "${BINARY_MODE}" == "${BINARY_MODE_PULSE}" ]]; then
        echo "Installing Pulse ..."
        apt-get update
        apt-get install squeezelite-pulseaudio --no-install-recommends -y
        cp /usr/bin/squeezelite-pulseaudio /app/bin/squeezelite-pulseaudio
        echo "Installed PULSE."
    fi
    apt-get remove squeezelite* -y
else
    echo "Invalid BUILD_MODE=[${BUILD_MODE}]"
    exit 1
fi