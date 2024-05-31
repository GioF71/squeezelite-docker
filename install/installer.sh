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

url_left="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/"
url_right="/download"

declare -A url_middle_alsa_dict
url_middle_alsa_dict[$arch_amd64]="squeezelite-2.0.0.1488-x86_64.tar.gz"
url_middle_alsa_dict[$arch_arm_v7]="squeezelite-2.0.0.1486-armhf.tar.gz"
url_middle_alsa_dict[$arch_arm_v8]="squeezelite-2.0.0.1465-aarch64.tar.gz"

declare -A url_middle_pulse_dict
url_middle_pulse_dict[$arch_amd64]="squeezelite-pulse-2.0.0.1488-x86_64.tar.gz"
url_middle_pulse_dict[$arch_arm_v7]="squeezelite-pulse-1.9.9.1392-armhf.tar.gz"
url_middle_pulse_dict[$arch_arm_v8]="squeezelite-pulse-2.0.0.1465-aarch64.tar.gz"

if [[ "${BUILD_MODE}" == "sf" ]]; then
    apt-get install wget -y
    #ARCH=`uname -m`
    mkdir /assets
    mkdir -p /assets/sourceforge
    if [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "alsa" ]]; then
        SL_URL=${url_middle_alsa_dict["${ARCH}"]};
        if [[ -n "${url_left}${SL_URL}${url_right}" ]]; then
            echo "Found Alsa version for architecture ${ARCH}, downloading ..."
            wget "${url_left}${SL_URL}${url_right}" -O /assets/sourceforge/squeezelite.tar.gz
            mkdir /assets/sourceforge/expanded
            tar xzvf /assets/sourceforge/squeezelite.tar.gz -C /assets/sourceforge/expanded
            ls -la /assets/sourceforge/expanded/
            mv /assets/sourceforge/expanded/squeezelite $OUTPUT_FILE
        else
            echo "NOT Found Alsa version for architecture ${ARCH}. This was mandatory, exiting!"
            exit 1
        fi
    fi
    if [[ "${BINARY_MODE}" == "full" ]] || [[ "${BINARY_MODE}" == "pulse" ]]; then
        SL_URL_PULSE=${url_middle_pulse_dict["${ARCH}"]};
        if [[ -n "${url_left}${SL_URL_PULSE}${url_right}" ]]; then
            echo "Found PulseAudio version for architecture ${ARCH}, downloading ..."
            wget "${url_left}${SL_URL_PULSE}${url_right}" -O /assets/sourceforge/squeezelite-pulse.tar.gz
            mkdir /assets/sourceforge/expanded-pulse
            tar xzvf /assets/sourceforge/squeezelite-pulse.tar.gz -C /assets/sourceforge/expanded-pulse
            ls -la /assets/sourceforge/expanded-pulse/
            mv /assets/sourceforge/expanded-pulse/squeezelite $OUTPUT_FILE_PULSE
        else
            echo "NOT Found PulseAudio version for architecture ${ARCH}. This was not mandatory."
        fi
    fi
    # cleanup
    apt-get purge wget -y
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