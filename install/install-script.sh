set -ex

# Error codes
# 1 Unsupported platform

ARCH=`uname -m`
OUTPUT_FILE=/app/bin/squeezelite
OUTPUT_FILE_PULSE=/app/bin/squeezelite-pulseaudio
echo "Architecture: ${ARCH}"

arch_amd64=x86_64
arch_arm_v7=armv7l
arch_arm_v8=aarch64

declare -A download_url_dict_alsa
download_url_dict_alsa[$arch_amd64]="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1421-x86_64.tar.gz/download"
download_url_dict_alsa[$arch_arm_v7]="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1419-armhf.tar.gz/download"
download_url_dict_alsa[$arch_arm_v8]="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1392-aarch64.tar.gz/download"

declare -A download_url_dict_pulse
download_url_dict_pulse[$arch_amd64]="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-pulse-1.9.9.1421-x86_64.tar.gz/download"
download_url_dict_pulse[$arch_arm_v7]="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-pulse-1.9.9.1392-armhf.tar.gz/download"
download_url_dict_pulse[$arch_arm_v8]="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-pulse-1.9.9.1392-aarch64.tar.gz/download"

if [ "$DOWNLOADED_BIN" == "Y" ]; then
    apt-get install wget -y    
    ARCH=`uname -m`
    mkdir /assets
    mkdir -p /assets/sourceforge
    SL_URL=${download_url_dict_alsa["${ARCH}"]};
    if [[ -n "${SL_URL}" ]]; then
        echo "Found Alsa version for architecture ${ARCH}, downloading ..."
        wget $SL_URL -O /assets/sourceforge/squeezelite.tar.gz
        mkdir /assets/sourceforge/expanded
        tar xzvf /assets/sourceforge/squeezelite.tar.gz -C /assets/sourceforge/expanded
        ls -la /assets/sourceforge/expanded/
        mv /assets/sourceforge/expanded/squeezelite $OUTPUT_FILE
    else
        echo "NOT Found Alsa version for architecture ${ARCH}. This was mandatory, exiting!"
        exit 1
    fi
    SL_URL_PULSE=${download_url_dict_pulse["${ARCH}"]};
    if [[ -n "${SL_URL_PULSE}" ]]; then
        echo "Found PulseAudio version for architecture ${ARCH}, downloading ..."
        wget $SL_URL_PULSE -O /assets/sourceforge/squeezelite-pulse.tar.gz
        mkdir /assets/sourceforge/expanded-pulse
        tar xzvf /assets/sourceforge/squeezelite-pulse.tar.gz -C /assets/sourceforge/expanded-pulse
        ls -la /assets/sourceforge/expanded-pulse/
        mv /assets/sourceforge/expanded-pulse/squeezelite $OUTPUT_FILE_PULSE
    else
        echo "NOT Found PulseAudio version for architecture ${ARCH}. This was not mandatory."
    fi
    # cleanup
    apt-get purge wget -y
    apt-get autoremove -y
    rm -Rf /assets
else
    apt-get install squeezelite --no-install-recommends -y
    cp /usr/bin/squeezelite /app/bin/squeezelite
    apt-get install squeezelite-pulseaudio --no-install-recommends -y
    cp /usr/bin/squeezelite-pulseaudio /app/bin/squeezelite-pulseaudio
    apt-get remove squeezelite* -y
fi