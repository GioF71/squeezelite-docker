#!/bin/bash

declare -A base_images

base_images[buster]=debian:buster-20211220-slim
base_images[bullseye]=debian:bullseye-20211220-slim
base_images[focal]=ubuntu:focal-20220105

DEFAULT_BASE_IMAGE=bullseye
DEFAULT_SOURCEFORGE_DOWNLOAD=N
DEFAULT_TAG=latest
download=$DEFAULT_SOURCEFORGE_DOWNLOAD
tag=$DEFAULT_TAG

while getopts b:d:t: flag
do
    case "${flag}" in
        b) base_image=${OPTARG};;
        d) download=${OPTARG};;
        t) tag=${OPTARG};;
    esac
done

echo "base_image: $base_image";
echo "sourceforge download: $sd";
echo "tag: $tag";

if [ -z "${base_image}" ]; then
  base_image=$DEFAULT_BASE_IMAGE
fi

#if [ -z "${sd}" && ]; then
if [ "${download}" == "Y" ]; then  
  download="Y"
elif [ "${download}" == "N" ]; then  
  download="N"
fi

expanded_base_image=${base_images[$base_image]}
echo "Base Image: ["$expanded_base_image"]"

echo "Download from SourceForge: ["$download"]"
echo "Tag: ["$tag"]"

docker build . \
    --build-arg BASE_IMAGE=${expanded_base_image} \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=${download}

#docker build . \
#    --build-arg BASE_IMAGE=${expanded_base_image} \
#    --build-arg DOWNLOAD_FROM_SOURCEFORGE=Y

