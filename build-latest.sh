#!/bin/sh

docker build \
    --push \
    --platform linux/arm/v7,linux/amd64 \
    --build-arg BASE_IMAGE=debian:bullseye-20211220-slim \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=Y \
    --tag giof71/squeezelite:latest-test-2022-01-22-01-13 \
    .
