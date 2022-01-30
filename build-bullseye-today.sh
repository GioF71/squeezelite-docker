#!/bin/sh

TODAY=`date +%F`
echo "TODAY: $TODAY"

docker build \
    --push \
    --platform linux/arm/v7,linux/amd64 \
    --build-arg BASE_IMAGE=debian:bullseye-20220125-slim \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=Y \
    --tag giof71/squeezelite-1.9.9-sourceforge-bullseye-$TODAY \
    .
