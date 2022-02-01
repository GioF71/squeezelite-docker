ARG BASE_IMAGE

FROM ${BASE_IMAGE}
ARG DOWNLOAD_FROM_SOURCEFORGE

RUN mkdir /stage0
COPY /install/asset_copier.sh /stage0
RUN chmod 755 /stage0/asset_copier.sh

RUN echo "disable cache 001"

# copy assets
RUN mkdir /assets
RUN mkdir /assets/sourceforge -p
RUN mkdir /assets/sourceforge/aarch64 -p
RUN mkdir /assets/sourceforge/armv7l -p
RUN mkdir /assets/sourceforge/x86_64 -p

COPY assets/aarch64 /assets/sourceforge/aarch64/
COPY assets/armv7l /assets/sourceforge/armv7l/
COPY assets/x86_64 /assets/sourceforge/x86_64/

RUN echo "Assets files__:"
RUN ls -la /assets/sourceforge/*/*

RUN echo "disable cache 004"

RUN /stage0/asset_copier.sh $DOWNLOAD_FROM_SOURCEFORGE

RUN ls -la /usr/bin/squeezelite

# SECOND STAGE #
ARG BASE_IMAGE
FROM ${BASE_IMAGE}
ARG DOWNLOAD_FROM_SOURCEFORGE

RUN apt-get update
#RUN apt-get install libasound2 -y

RUN mkdir /app
RUN mkdir /app/bin/

COPY --from=0 /usr/bin/squeezelite /app/bin/squeezelite

RUN mkdir /install
COPY install/*.sh /install/
RUN chmod u+x /install/*

RUN /install/installer.sh $DOWNLOAD_FROM_SOURCEFORGE

# copy assets
#RUN mkdir /assets
#RUN mkdir /assets/sourceforge -p
#RUN mkdir /assets/sourceforge/aarch64 -p
#RUN mkdir /assets/sourceforge/armhf -p
#RUN mkdir /assets/sourceforge/x86_64 -p

#COPY assets/aarch64 /assets/sourceforge/aarch64/
#COPY assets/armhf /assets/sourceforge/armhf/
#COPY assets/x86_64 /assets/sourceforge/x86_64/

#RUN echo "Assets:"
#RUN ls -la /assets/sourceforge/

#RUN /bin/bash -c 'if [[ -z "${DOWNLOAD_FROM_SOURCEFORGE}" || "${DOWNLOAD_FROM_SOURCEFORGE}" == "Y" ]]; then \
#   /install/sl_sourceforge_download.sh; \
#else \
#    /install/sl_repo_install.sh; \
#fi'

# remove assets
#RUN rm -Rf /assets

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
ENV SQUEEZELITE_TIMEOUT
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
ENV SQUEEZELITE_BUFFER_SIZE ""

WORKDIR /

ENTRYPOINT ["/run-squeezelite.sh"]
