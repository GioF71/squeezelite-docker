ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS BASE
ARG DOWNLOAD_FROM_SOURCEFORGE
ARG USE_APT_PROXY

RUN mkdir -p /app/conf

COPY app/conf/01-apt-proxy /app/conf/

RUN echo "USE_APT_PROXY=["${USE_APT_PROXY}"]"

RUN if [ "${USE_APT_PROXY}" = "Y" ]; then \
    echo "Builind using apt proxy"; \
    cp /app/conf/01-apt-proxy /etc/apt/apt.conf.d/01-apt-proxy; \
    cat /etc/apt/apt.conf.d/01-apt-proxy; \
    else \
    echo "Building without apt proxy"; \
    fi

# update indexes
RUN apt-get update

# upgrade packages
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# install pulseaudio
RUN apt-get install pulseaudio --no-install-recommends -y

# install alsa libraries
RUN apt-get install libasound2 --no-install-recommends -y

# copy installer files
RUN mkdir -p /app/bin
RUN mkdir -p /app/install
COPY install/installer.sh /app/install/
COPY install/install-script.sh /app/install/
RUN chmod u+x /app/install/*

WORKDIR /app/install

# execute installation
RUN ./installer.sh $DOWNLOAD_FROM_SOURCEFORGE

# cleanup apt cache
RUN rm -rf /var/lib/apt/lists/*

# remove scripts
RUN rm -Rf /app/install

## test binary in both cases
RUN /app/bin/squeezelite -?
RUN /app/bin/squeezelite-pulseaudio -?

FROM scratch
COPY --from=BASE / /

LABEL maintainer="GioF71"
LABEL source="https://github.com/GioF71/squeezelite-docker"

RUN mkdir -p /app
RUN mkdir -p /app/bin
RUN mkdir -p /app/conf
RUN mkdir -p /app/doc
RUN mkdir -p /app/assets

ENV SQUEEZELITE_MODE ""
ENV SQUEEZELITE_AUDIO_DEVICE ""
ENV SQUEEZELITE_MIXER_DEVICE ""
ENV SQUEEZELITE_MAC_ADDRESS ""
ENV SQUEEZELITE_NAME ""
ENV SQUEEZELITE_MODEL_NAME ""
ENV SQUEEZELITE_TIMEOUT ""
ENV SQUEEZELITE_DELAY ""

ENV STARTUP_DELAY_SEC ""

ENV SQUEEZELITE_SERVER_PORT ""

ENV SQUEEZELITE_RATES ""
ENV SQUEEZELITE_UPSAMPLING ""

ENV PRESET ""

ENV SQUEEZELITE_PARAMS ""
ENV SQUEEZELITE_CODECS ""
ENV SQUEEZELITE_EXCLUDE_CODECS ""
ENV SQUEEZELITE_PRIORITY ""
ENV SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE ""
ENV SQUEEZELITE_BUFFER_SIZE ""
ENV SQUEEZELITE_UNMUTE ""
ENV SQUEEZELITE_VOLUME_CONTROL ""
ENV SQUEEZELITE_LINEAR_VOLUME ""
ENV SQUEEZELITE_VISUALIZER ""

ENV SQUEEZELITE_LOG_CATEGORY_ALL ""
ENV SQUEEZELITE_LOG_CATEGORY_SLIMPROTO ""
ENV SQUEEZELITE_LOG_CATEGORY_STREAM ""
ENV SQUEEZELITE_LOG_CATEGORY_DECODE ""
ENV SQUEEZELITE_LOG_CATEGORY_OUTPUT ""
ENV SQUEEZELITE_LOG_CATEGORY_IR ""

ENV DISPLAY_PRESETS ""

ENV PUID ""
ENV PGID ""
ENV AUDIO_GID ""

COPY app/bin/run-squeezelite.sh /app/bin/
COPY app/bin/run-squeezelite-alsa.sh /app/bin/
COPY app/bin/run-squeezelite-pulse.sh /app/bin/
COPY app/bin/cmd-line-builder.sh /app/bin/
COPY app/bin/logging.sh /app/bin/
COPY app/bin/run-presets.sh /app/bin/

RUN chmod +x /app/bin/*.sh

VOLUME '/app/assets/additional-presets.conf'

COPY README.md /app/doc/
COPY doc/* /app/doc/
COPY app/assets/builtin-presets.conf /app/assets/
COPY app/assets/pulse-client-template.conf /app/assets/pulse-client-template.conf

WORKDIR /app/bin

ENTRYPOINT ["/app/bin/run-squeezelite.sh"]
