#!/bin/sh

docker build \
    --push \
    --platform linux/arm/v7,linux/arm64/v8,linux/amd64 
    --build-arg BASE_IMAGE=bulleye \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=Y
    --tag giof71/squeezelite:latest \
    .
