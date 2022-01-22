ARG BASE_IMAGE
ARG DOWNLOAD_FROM_SOURCEFORGE

FROM $BASE_IMAGE

RUN apt-get update

RUN mkdir /install

COPY install/*.sh /install/
RUN chmod u+x /install/*

# copy assets
RUN mkdir /assets
RUN mkdir /assets/sourceforge -p
RUN mkdir /assets/sourceforge/aarch64 -p
RUN mkdir /assets/sourceforge/armhf -p
RUN mkdir /assets/sourceforge/x86_64 -p

COPY assets/aarch64 /assets/sourceforge/aarch64/
COPY assets/armhf /assets/sourceforge/armhf/
COPY assets/x86_64 /assets/sourceforge/x86_64/

RUN echo "Assets:"
RUN ls -la /assets/sourceforge/

RUN /bin/bash -c 'if [[ -z "${DOWNLOAD_FROM_SOURCEFORGE}" || "${DOWNLOAD_FROM_SOURCEFORGE}" == "Y" ]]; then \
   /install/sl_sourceforge_download.sh; \
else \
    /install/sl_repo_install.sh; \
fi'

# remove assets
RUN rm -Rf /assets

# remove scripts
RUN rm -Rf /install

## test binary in both cases
RUN /usr/bin/squeezelite -?

RUN rm -rf /var/lib/apt/lists/*


COPY run-squeezelite.sh /run-squeezelite.sh
COPY run-presets.sh /run-presets.sh
RUN chmod u+x /run-squeezelite.sh
RUN chmod u+x /run-presets.sh

ENV SQUEEZELITE_AUDIO_DEVICE ""
ENV SQUEEZELITE_MIXER_DEVICE ""
ENV SQUEEZELITE_MAC_ADDRESS ""
ENV SQUEEZELITE_NAME ""
ENV SQUEEZELITE_MODEL_NAME ""
ENV SQUEEZELITE_TIMEOUT 2
ENV SQUEEZELITE_DELAY 500

ENV STARTUP_DELAY_SEC 0

ENV SQUEEZELITE_SERVER_PORT ""

ENV SQUEEZELITE_RATES ""
ENV SQUEEZELITE_UPSAMPLING ""

ENV PRESET ""

ENV SQUEEZELITE_PARAMS ""
ENV SQUEEZELITE_CODECS ""
ENV SQUEEZELITE_PRIORITY ""
ENV SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE ""

WORKDIR /

ENTRYPOINT ["/run-squeezelite.sh"]
