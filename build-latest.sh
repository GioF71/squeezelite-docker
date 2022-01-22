#!/bin/sh

docker build \
    --push \
<<<<<<< HEAD
    --platform linux/arm/v7,linux/arm64/v8,linux/amd64 
    --build-arg BASE_IMAGE=bulleye \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=Y
    --tag giof71/squeezelite:latest \
=======
    --platform linux/arm/v7,linux/amd64 \
    --build-arg BASE_IMAGE=debian:bullseye-20211220-slim \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=Y \
    --tag giof71/squeezelite:latest-test-2022-01-22-01-13 \
>>>>>>> ce1c125a211b8079d14cee7a446ab5898f607a7a
    .
