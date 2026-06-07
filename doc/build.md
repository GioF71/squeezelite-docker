# Build

You can build (or rebuild) the image by opening a terminal and using the convenience script `build.sh`.
This script accepts a few parameters:

Parameter|Default|Description
:---:|:---:|:---
-d|N|Use repository (`N`) or download from SourceForge (`Y`)
-b|trixie|Base image, you can choose among `stable`, `trixie`, `bookworm`
-t|local|The last part of the tag, by default it will be giof71/squeezelite:latest
-d|std|Build mode, you can choose among `std` (repository versions), `sf` (for sourceforge binaries) and `r2` (compiles the r2 fork)
-m|full|Binary mode, you can choose among `full` , `pulse` and `alsa-bt`

A few examples:

Command|Expected Result
:---|:---
./build.sh|Builds from Debian `bookworm`, using the binary version from the repos, use the `local` tag
./build.sh -d N -b trixie -t latest|Same as above, but everything is explicitly specified
./build.sh -d N -b trixie -t local|Builds from Debian `trixie`, will not download from SourceForge, use `local` as the tag.
./build.sh -d Y -b bookworm -t bookworm-sf|Builds from Debian `bookworm`, download from SourceForge, use `bookworm-sf` as the tag.

It will take a few minutes of your time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.
