#!/bin/sh

#linux/arm64/v8

docker build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag giof71/squeezelite:stable .
