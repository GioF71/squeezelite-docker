# Build

You can build (or rebuild) the image by opening a terminal and using the convenience script `build.sh`.
This script accepts a few parameters:

Parameter|Default|Description
:---:|:---:|:---
-d|N|Use repository (`N`) or download from SourceForge (`Y`)
-b|bullseye|Base image, you can choose among `bookworm`, `bullseye`, `buster` and `jammy`
-t|latest|The last part of the tag, by default it will be giof71/squeezelite:latest
-p|N|Use apt-proxy specified in app/conf/01-apt-proxy

Example:

Command|Expected Result
:---|:---
./build.sh|Builds from Debian `bookworm``, using the binary version from the repos, use the `latest` tag
./build.sh -d N -b bookworm -t latest|Same as above, but everything is explicitly specified
./build.sh -d N -b bookworm -t local|Builds from Debian `bookworm`, will not download from SourceForge, use `local` as the tag.
./build.sh -d Y -b bullseye -t bullseye-sf|Builds from Debian `bullseye`, download from SourceForge, use `bullseye-sf` as the tag.

It will take a few minutes of your time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.
