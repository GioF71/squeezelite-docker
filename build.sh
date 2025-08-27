#!/bin/bash

set -ex

# error codes
# 2 Invalid base image
# 3 Invalid build_mode parameter
# 4 Invalid proxy parameter

declare -A base_images

base_images[sid]=debian:sid-slim
base_images[stable]=debian:stable-slim
base_images[unstable]=debian:unstable-slim
base_images[trixie]=debian:trixie-slim
base_images[bookworm]=debian:bookworm-slim
base_images[bullseye]=debian:bullseye-slim

base_images[debian:sid]=debian:sid-slim
base_images[debian:stable]=debian:stable-slim
base_images[debian:unstable]=debian:unstable-slim
base_images[debian:trixie]=debian:trixie-slim
base_images[debian:bookworm]=debian:bookworm-slim
base_images[debian:bullseye]=debian:bullseye-slim

DEFAULT_BASE_IMAGE=stable
DEFAULT_BUILD_MODE=std
DEFAULT_TAG=local
DEFAULT_USE_PROXY=N

build_mode=$DEFAULT_BUILD_MODE
tag=$DEFAULT_TAG

while getopts b:d:t:p:m:f: flag
do
    case "${flag}" in
        b) base_image=${OPTARG};;
        d) build_mode=${OPTARG};;
        t) tag=${OPTARG};;
        p) proxy=${OPTARG};;
        m) binary_mode=${OPTARG};;
        f) force_arch=${OPTARG};;
    esac
done

echo "Input: Base Image = [$base_image]";
echo "Input: Build Mode = [$build_mode]";
echo "Input: Download from SourceForge = [$d]";
echo "Input: Force Architecture = [$force_arch]";
echo "Input: Image Tag = [$tag]";
echo "Input: Proxy = [$proxy]";
echo "Input: Binary mode = [$binary_mode]";

if [ -z "${base_image}" ]; then
  base_image=$DEFAULT_BASE_IMAGE
fi

expanded_base_image=${base_images[$base_image]}
if [ -z "${expanded_base_image}" ]; then
  echo "invalid base image ["${base_image}"]"
  exit 2
fi

if [ -z "${build_mode}" ]; then
  build_mode="std"
fi

if [[ "${build_mode}" == "sf" ]]; then  
  build_mode="sf"
elif [[ "${build_mode}" == "std" ]]; then  
  build_mode="std"
elif [[ "${build_mode}" == "r2" ]]; then  
  build_mode="r2"
else
  echo "invalid build_mode parameter ["${build_mode}"]"
  exit 3
fi

if [ -z "${proxy}" ]; then
  proxy="N"
fi
if [[ "${proxy^^}" == "Y" || "${proxy^^}" == "YES" ]]; then  
  proxy="Y"
elif [[ "${proxy^^}" == "N" || "${proxy^^}" == "NO" ]]; then  
  proxy="N"
else
  echo "invalid proxy parameter ["${proxy}"]"
  exit 4
fi

if [[ -z "${binary_mode}" ]]; then
  binary_mode=full
else
  if [[ ! "${binary_mode}" == "alsa" ]] && [[ ! "${binary_mode}" == "pulse" ]] && [[ ! "${binary_mode}" == "full" ]] && [[ ! "${binary_mode}" == "alsa-bt" ]]; then
    echo "invalid binary_mode parameter ["${binary_mode}"]"
    exit 4
  fi
fi

echo "Build Argument: Base Image = ["$expanded_base_image"]"
echo "Build Argument: Download from SourceForge = ["$build_mode"]"
echo "Build Argument: Force Architecture = [$force_arch]";
echo "Build Argument: Image Tag = ["$tag"]"
echo "Build Argument: Binary Mode = ["$binary_mode"]"
echo "Build Argument: Proxy = ["$proxy"]"

docker build . \
    --build-arg BASE_IMAGE=${expanded_base_image} \
    --build-arg BUILD_MODE=${build_mode} \
    --build-arg BINARY_MODE=${binary_mode} \
    --build-arg FORCE_ARCH=${force_arch} \
    --build-arg USE_APT_PROXY=${proxy} \
    -t giof71/squeezelite:$tag \
    --progress=plain
