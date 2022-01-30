#!/bin/sh

docker build \
    --push \
    --platform linux/arm/v7,linux/amd64 \
    --build-arg BASE_IMAGE=debian:buster-20220125-slim \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=N \
    --tag giof71/squeezelite:stable \
    .
