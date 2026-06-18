# Build

## Using build arguments

A table of the build arguments:

NAME|DESCRIPTION
:---|:---
BASE_IMAGE|Base image, e.g. `debian:stable-slim` (default), `debian:trixie-slim`, `debian:bookworm-slim`
BUILD_MODE|Build mode, you can choose among `std` (repository versions, default), `sf` (for sourceforge binaries) and `r2` (compiles the r2 fork)
BINARY_MODE|Binary mode, you can choose among `full` (default), `alsa`, `pulse` and `alsa-bt`
FORCE_ARCH|Force build using the specified architecture, empty by default

## Using the provided script

You can build (or rebuild) the image by opening a terminal and using the convenience script `build.sh`.
This script accepts a few parameters:

Parameter|Default|Description
:---:|:---:|:---
-b|trixie|Base image, you can choose among `stable`, `trixie`, `bookworm`
-d|std|See build argument `BUILD_MODE`
-m|full|See build argument `BINARY_MODE`
-f||See build argument `FORCE_ARCH`
-t|local|The last part of the tag, by default it will be giof71/squeezelite:latest

A few examples:

Command|Expected Result
:---|:---
./build.sh|Builds from Debian `bookworm`, using the binary version from the repos, use the `local` tag
./build.sh -d N -b trixie -t latest|Same as above, but everything is explicitly specified
./build.sh -d N -b trixie -t local|Builds from Debian `trixie`, will not use SourceForge binaries, use `local` as the tag.
./build.sh -d Y -b bookworm -t bookworm-sf|Builds from Debian `bookworm`, use SourceForge binaries, use `bookworm-sf` as the tag.

It will take a few minutes of your time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.
