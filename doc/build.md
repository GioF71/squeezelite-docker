# Build

You can build (or rebuild) the image by opening a terminal and using the convenience script `build.sh`.
This script accepts a few parameters:

Parameter|Default|Description
:---:|:---:|:---
-d|N|Use repository (`N`) or download from SourceForge (`Y`)
-b|bullseye|Base image, you can choose among `bullseye`, `buster` and `jammy`
-t|latest|The last part of the tag, by default it will be giof71/squeezelite:latest

Example:

Command|Expected Result
:---|:---
./build.sh|Builds from Debian Bullseye, using the binary version from the repos, use the `latest` tag
./build.sh -d N -b bullseye -t latest|Same as above, but everything is explicitly specified
./build.sh -d Y -b buster -t buster-sf|Builds from Debian Buster, download from SourceForge, use `buster-sf` as the tag.

It will take a few minutes of your time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.

