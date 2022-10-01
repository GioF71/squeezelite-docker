#!/bin/bash

# error codes
# 2 Invalid base image
# 3 Invalid download parameter
# 4 Invalid proxy parameter

declare -A base_images

base_images[bookworm]=debian:bookworm-slim
base_images[buster]=debian:buster-slim
base_images[bullseye]=debian:bullseye-slim
base_images[jammy]=ubuntu:jammy

DEFAULT_BASE_IMAGE=bullseye
DEFAULT_SOURCEFORGE_DOWNLOAD=N
DEFAULT_TAG=latest
DEFAULT_USE_PROXY=N

download=$DEFAULT_SOURCEFORGE_DOWNLOAD
tag=$DEFAULT_TAG

while getopts b:d:t:p: flag
do
    case "${flag}" in
        b) base_image=${OPTARG};;
        d) download=${OPTARG};;
        t) tag=${OPTARG};;
        p) proxy=${OPTARG};;
    esac
done

echo "base_image: $base_image";
echo "sourceforge download: $sd";
echo "tag: $tag";
echo "proxy: [$proxy]";

if [ -z "${base_image}" ]; then
  base_image=$DEFAULT_BASE_IMAGE
fi

expanded_base_image=${base_images[$base_image]}
if [ -z "${expanded_base_image}" ]; then
  echo "invalid base image ["${base_image}"]"
  exit 2
fi

if [ -z "${download}" ]; then
  download="Y"
fi

if [[ "${download}" == "Y" || "${download}" == "y" ]]; then  
  download="Y"
elif [[ "${download}" == "N" || "${download}" == "n" ]]; then  
  download="N"
else
  echo "invalid download parameter ["${download}"]"
  exit 3
fi

if [ -z "${proxy}" ]; then
  proxy="N"
fi
if [[ "${proxy}" == "Y" || "${proxy}" == "y" ]]; then  
  proxy="Y"
elif [[ "${proxy}" == "N" || "${proxy}" == "n" ]]; then  
  proxy="N"
else
  echo "invalid proxy parameter ["${proxy}"]"
  exit 4
fi


echo "Base Image: ["$expanded_base_image"]"
echo "Download from SourceForge: ["$download"]"
echo "Tag: ["$tag"]"
echo "Proxy: ["$proxy"]"

docker build . \
    --build-arg BASE_IMAGE=${expanded_base_image} \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=${download} \
    --build-arg USE_APT_PROXY=${proxy} \
    -t giof71/squeezelite:$tag
