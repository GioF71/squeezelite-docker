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

arch_amd64=x86_64
arch_arm_v7=armv7l
arch_arm_v8=aarch64

declare -A alsa_file_dict
alsa_file_dict[$arch_amd64]="squeezelite-2.0.0.1541-x86_64.tar.gz"
alsa_file_dict[$arch_arm_v8]="squeezelite-2.0.0.1541-aarch64.tar.gz"
alsa_file_dict[$arch_arm_v7]="squeezelite-2.0.0.1541-armhf.tar.gz"

declare -A pulse_file_dict
pulse_file_dict[$arch_amd64]="squeezelite-pulse-2.0.0.1541-x86_64.tar.gz"
pulse_file_dict[$arch_arm_v8]="squeezelite-pulse-2.0.0.1541-aarch64.tar.gz"

if [[ "${BUILD_MODE}" == "sf" ]]; then
    if [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "alsa" ]]; then
        SL_ALSA_FILENAME=${alsa_file_dict["${ARCH}"]};
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
    if [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "pulse" ]]; then
        SL_PULSE_FILENAME=${pulse_file_dict["${ARCH}"]};
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
elif [[ "${BUILD_MODE}" == "r2" ]]; then
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
elif [[ "${BUILD_MODE}" == "std" ]]; then
    if [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "alsa" ]] || [[ "${BINARY_MODE}" == "alsa-bt" ]]; then
        echo "Installing ALSA ..."
        apt-get update
        apt-get install squeezelite --no-install-recommends -y
        cp /usr/bin/squeezelite /app/bin/squeezelite
        echo "Installed ALSA."
    fi
    if [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "pulse" ]]; then
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