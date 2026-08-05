#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 7 ]]; then
  echo "Usage: $0 <image_name> <ref_type> <ref_name> <ref> <base> <build_mode> <binary_mode>" >&2
  exit 1
fi

image_name=$1
ref_type=$2
ref_name=$3
ref=$4
base=$5
build_mode=$6
binary_mode=$7

output_file="${GITHUB_OUTPUT:-/dev/stdout}"

echo "REF_TYPE: [$ref_type]"
echo "REF_NAME: [$ref_name]"
echo "REF: [$ref]"

build_platforms="linux/amd64,linux/arm64/v8"
if [[ "$build_mode" = "sf" ]] || [[ "$build_mode" = "sf_ffmpeg" ]]; then
  if [[ "$binary_mode" != "full" ]] && [[ "$binary_mode" != "pulse" ]]; then
    build_platforms="${build_platforms},linux/arm/v7"
  fi
elif [[ "$build_mode" = "std" ]] || [[ "$build_mode" = "r2" ]]; then
  build_platforms="${build_platforms},linux/arm/v7,linux/arm/v5"
fi

declare -A base_image_from_matrix
base_image_from_matrix[sid]=debian:sid-slim
base_image_from_matrix[trixie]=debian:trixie-slim
base_image_from_matrix[bookworm]=debian:bookworm-slim

select_base_image=${base_image_from_matrix[$base]:-debian:stable-slim}
echo "Select Base Image [$select_base_image]"

declare -A sl_versions
sl_versions[stable]=current

declare -A special_tags
special_tags[stable-std-full]="${image_name}:latest,${image_name}:stable"
special_tags[stable-std-alsa]="${image_name}:latest-alsa,${image_name}:stable-alsa"
special_tags[stable-std-pulse]="${image_name}:latest-pulse,${image_name}:stable-pulse"
special_tags[stable-sf-full]="${image_name}:sourceforge-latest,${image_name}:sourceforge-stable"
special_tags[stable-sf-alsa]="${image_name}:sourceforge-latest-alsa,${image_name}:sourceforge-stable-alsa"
special_tags[stable-sf-pulse]="${image_name}:sourceforge-latest-pulse,${image_name}:sourceforge-stable-pulse"
special_tags[stable-r2-alsa]="${image_name}:r2-latest-alsa,${image_name}:r2-stable-alsa"
special_tags[stable-sf_ffmpeg-alsa]="${image_name}:sourceforge-latest-ffmpeg-alsa,${image_name}:sourceforge-stable-ffmpeg-alsa"
special_tags[stable-sf_ffmpeg-pulse]="${image_name}:sourceforge-latest-ffmpeg-pulse,${image_name}:sourceforge-stable-ffmpeg-pulse"

declare -A distro_friendly_name_dict
distro_friendly_name_dict[stable]=debian

distro_friendly_name=$base
lookup_distro_name=${distro_friendly_name_dict[$base]:-}
if [[ -n "$lookup_distro_name" ]]; then
  distro_friendly_name=$lookup_distro_name
fi

squeezelite_version_str=""
if [[ "$build_mode" = "sf" ]]; then
  squeezelite_version_str="squeezelite-current-sourceforge"
elif [[ "$build_mode" = "sf_ffmpeg" ]]; then
  squeezelite_version_str="squeezelite-current-sourceforge-ffmpeg"
elif [[ "$build_mode" = "r2" ]]; then
  squeezelite_version_str="squeezelite-1.8.4-r2"
else
  select_squeezelite_version=${sl_versions[$base]:-unknown}
  if [[ -z "$select_squeezelite_version" ]]; then
    select_squeezelite_version=version-unknown
  fi
  echo "Version from dictionary: $select_squeezelite_version from [$base]"
  squeezelite_version_str="squeezelite-$select_squeezelite_version"
fi

tags=""
if [[ "$ref_type" = "tag" ]]; then
  echo "tag mode"
  echo "tag is [$ref_name]"
  if [[ "$ref_name" = */* ]]; then
    tag_type=$(echo "$ref_name" | cut -d '/' -f 1)
    tag_name=$(echo "$ref_name" | cut -d '/' -f 2)
  else
    if [[ "$ref_name" = v* ]] || [[ "$ref_name" = f* ]] || [[ "$ref_name" = d* ]]; then
      tag_type=${ref_name:0:1}
      tag_name=${ref_name:1}
    fi
  fi
  echo "tag_type=[$tag_type]"
  echo "tag_name=[$tag_name]"
  if [[ "$tag_type" == "release" || "$tag_type" == "v" ]]; then
    echo "release tag"
    tags="$image_name:${distro_friendly_name}-${binary_mode}-${squeezelite_version_str}"
    tags="$tags,$image_name:${distro_friendly_name}-${binary_mode}-${squeezelite_version_str}-${tag_name}"
    special_tag_lookup="${base}-${build_mode}-${binary_mode}"
    select_special_tags=${special_tags[$special_tag_lookup]:-}
    building_now="${distro_friendly_name}-${binary_mode}-${build_mode}"
    echo "Building now: [$building_now]"
    if [[ -n "$select_special_tags" ]]; then
      echo "Found special tags for [$building_now]=[$select_special_tags]"
      tags="$tags,${select_special_tags}"
    else
      echo "No special tags found for [$building_now]"
    fi
  elif [[ "$tag_type" == "feature" || "$tag_type" == "f" ]]; then
    echo "feature tag"
    tags="${image_name}:feature-${tag_name}-${distro_friendly_name}-${binary_mode}-${squeezelite_version_str}"
  elif [[ "$tag_type" = "daily" || "$tag_type" = "d" ]]; then
    echo "daily build"
    tags="${tags},${image_name}:daily-${distro_friendly_name}-${binary_mode}-${squeezelite_version_str}"
  fi
fi

echo "Building tags: [$tags]"

echo "RELEASE_TAGS=${tags}" >> "$output_file"
echo "BASE_IMAGE=${select_base_image}" >> "$output_file"
echo "BUILD_MODE=${build_mode}" >> "$output_file"
echo "BUILD_PLATFORMS=${build_platforms}" >> "$output_file"
