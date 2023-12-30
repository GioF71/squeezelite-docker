#!/bin/bash

# error codes
# 2 Invalid base image
# 3 Invalid download parameter
# 4 Invalid proxy parameter

declare -A base_images

base_images[sid]=debian:sid
base_images[stable]=debian:stable
base_images[unstable]=debian:unstable
base_images[trixie]=debian:trixie
base_images[bookworm]=debian:bookworm
base_images[bullseye]=debian:bullseye
base_images[buster]=debian:buster
base_images[trusty]=ubuntu:trusty
base_images[xenial]=ubuntu:xenial
base_images[bionic]=ubuntu:bionic
base_images[focal]=ubuntu:focal
base_images[jammy]=ubuntu:jammy
base_images[kinetic]=ubuntu:kinetic
base_images[lunar]=ubuntu:lunar
base_images[mantic]=ubuntu:mantic
base_images[rolling]=ubuntu:rolling

base_images[debian:sid]=debian:sid-slim
base_images[debian:stable]=debian:stable-slim
base_images[debian:unstable]=debian:unstable-slim
base_images[debian:trixie]=debian:trixie-slim
base_images[debian:bookworm]=debian:bookworm-slim
base_images[debian:bullseye]=debian:bullseye-slim
base_images[debian:buster]=debian:buster-slim
base_images[ubuntu:trusty]=ubuntu:trusty
base_images[ubuntu:xenial]=ubuntu:xenial
base_images[ubuntu:bionic]=ubuntu:bionic
base_images[ubuntu:focal]=ubuntu:focal
base_images[ubuntu:jammy]=ubuntu:jammy
base_images[ubuntu:kinetic]=ubuntu:kinetic
base_images[ubuntu:lunar]=ubuntu:lunar
base_images[ubuntu:mantic]=ubuntu:mantic
base_images[ubuntu:rolling]=ubuntu:rolling

DEFAULT_BASE_IMAGE=stable
DEFAULT_SOURCEFORGE_DOWNLOAD=N
DEFAULT_TAG=local
DEFAULT_USE_PROXY=N

download=$DEFAULT_SOURCEFORGE_DOWNLOAD
tag=$DEFAULT_TAG

while getopts b:d:t:p:m: flag
do
    case "${flag}" in
        b) base_image=${OPTARG};;
        d) download=${OPTARG};;
        t) tag=${OPTARG};;
        p) proxy=${OPTARG};;
        m) build_mode=${OPTARG};;
    esac
done

echo "Input: base_image = [$base_image]";
echo "Input: Download from SourceForge = [$sd]";
echo "Input: Image Tag = [$tag]";
echo "Input: Proxy = [$proxy]";
echo "Input: Build mode = [$build_mode]";

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
if [[ "${proxy^^}" == "Y" || "${proxy^^}" == "YES" ]]; then  
  proxy="Y"
elif [[ "${proxy^^}" == "N" || "${proxy^^}" == "NO" ]]; then  
  proxy="N"
else
  echo "invalid proxy parameter ["${proxy}"]"
  exit 4
fi

if [[ -z "${build_mode}" ]]; then
  build_mode=full
else
  if [[ ! "${build_mode^^}" == "ALSA" ]] && [[ ! "${build_mode^^}" == "PULSE" ]] && [[ ! "${build_mode^^}" == "FULL" ]]; then
    echo "invalid build_mode parameter ["${build_mode}"]"
    exit 4
  fi
fi

echo "Build Argument: Base Image = ["$expanded_base_image"]"
echo "Build Argument: Download from SourceForge = ["$download"]"
echo "Build Argument: Image Tag = ["$tag"]"
echo "Build Argument: Build Mode = ["$build_mode"]"
echo "Build Argument: Proxy = ["$proxy"]"

docker build . \
    --build-arg BASE_IMAGE=${expanded_base_image} \
    --build-arg DOWNLOAD_FROM_SOURCEFORGE=${download} \
    --build-arg BUILD_MODE=${build_mode} \
    --build-arg USE_APT_PROXY=${proxy} \
    -t giof71/squeezelite:$tag \
    --progress=plain
