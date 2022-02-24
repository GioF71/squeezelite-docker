# squeezeLite-Docker Release History

## Releases

### 2022-02-24

Feature|Description
:---|:---
README.md sync|Created Action for README.md synchronization
Releases.md|Release history moved out of README.md
Release history inclusion|The file `RELEASE.md` file is copied to the image at the path `/app/doc/RELEASE.md`

### 2022-02-23

Feature|Description
:---|:---
Repo update|The command `apt-get upgrade` is executed during the image build phase, so the image is up-to-date with the most current packages available at the release date
Add Volume Control support|Add support for the unmute `-V` switch (See the `SQUEEZELITE_VOLUME_CONTROL` variable)
Add Unmute support|Add support for the unmute `-U` switch (See the `SQUEEZELITE_UNMUTE` variable)
Add Linear volume adjustment support|Add support for linear volume adjustments using the `-X` switch (See the `SQUEEZELITE_LINEAR_VOLUME` variable)

### 2022-02-16

Feature|Description
:---|:---
Reviewed the presets loading mechanism|Defined a `builtin-presets.conf` file
Add DISPLAY_PRESETS environment variable|Allows to see all the preset values
Allow custom preset files through the volume `/app/assets/additional-presets.conf`|You can now inject custom presets for greater customizability

### 2022-02-14

Feature|Description
:---|:---
Preset table documentation|Reviewed the preset table layout on `README.md` file (docker hub compatibitily)
README.md sync|Added automatic synchronization of `README.md` file with the corresponding [repository](https://hub.docker.com/r/giof71/squeezelite) on [Docker Hub](https://hub.docker.com)
Tag fragment `focal` tag|Focal tag is now `focal` instead of `ubuntu-focal`
Preset to disable dsd|Added preset `no-dsd` which excludes DSD codec
Excluded codecs|Added support for excluded codecs (environment variable `SQUEEZELITE_EXCLUDE_CODECS` for the `-e` option)

### 2022-02-05

Feature|Description
:---|:---
Automated builds|Automated builds thanks to [Der-Henning](https://github.com/Der-Henning/)
Arm64 support|Builds for arm64 now available also thanks to [Der-Henning](https://github.com/Der-Henning/)
README.md inclusion|The `README.md` file is copied to the image at the path `/app/doc/README.md`

### 2022-02-04

Feature|Description
:---|:---
Build simplified|Simplified build process (not multistage anymore)
Image size reduction|Reduced image sizes (one line installation)
Convenience script doc|Documented the convenience build.sh script
Sourceforge tag correction|Corrected sourceforge tag names: sourceforge tags names were wrongly suggesting that the included SqueezeLite binary was at version 1.9.8 or 1.8 instead of version 1.9.9

### 2022-02-02

Feature|Description
:---|:---
Preset combination|Allowed combination of presets
SQUEEZELITE_DELAY fix|Fixed incorrect mapping for SQUEEZELITE_DELAY
`extremus` upsampling|Added `extremus` upsample setting
Rates|Rate presets defined

### 2022-01-30

Feature|Description
:---|:---
Sourceforce|Added images with SourceForge binaries (version 1.9.9)
SQUEEZELITE_BUFFER|Variable `SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE` renamed to `SQUEEZELITE_BUFFER`
