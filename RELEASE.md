# squeezeLite-Docker Release History

## Releases

### 2022-09-09

Feature|Description
:---|:---
Routine rebuild|Routine rebuild
Documentation update|Minor correction(s)

### 2022-08-05

Feature|Description
:---|:---
Routine rebuild|No changes, just a rebuild

### 2022-06-11

Feature|Description
:---|:---
Build process reviewed|No more base images with dates, removed some hard-coded stuff
News Presets|Add preset for Topping DX5 and Gustard X16
Documentation cleanup|Various errors corrected

### 2022-06-10

Feature|Description
:---|:---
Fixed ubuntu image documentation|SqueezeLite version was wrong
Fixed ubuntu image documentation|Focal was still mentioned
Image bump|Bump to latest debian and ubuntu base images

### 2022-06-09

Feature|Description
:---|:---
Add Visualizer support|Add support for the visualizer `-v` switch (See the `SQUEEZELITE_VISUALIZER` variable)

### 2022-04-30

Feature|Description
:---|:---
SourceForge updates|Arm 32bit client updated to version 1401
Base debian image bump|Bump for debian buster and bullseye
Base ubuntu image upgrade|Upgraded to jammy

### 2022-04-01

Feature|Description
:---|:---
Doc update|Asus Tinker situation apparently solved somehow

### 2022-03-29

Feature|Description
:---|:---
Doc update|Small corrections/typos

### 2022-03-19

Feature|Description
:---|:---
Add preset `pi-headphones`|Add preset for Raspberry Pi Headphone out
Doc update|Small corrections/typos

### 2022-03-14

Feature|Description
:---|:---
Successful tests on arm64|See the Prerequisites section of the [`README.md`](https://github.com/GioF71/squeezelite-docker/blob/main/README.md) file.
Sad DietPi Tinkerboard updates|See the Prerequisites section of the [`README.md`](https://github.com/GioF71/squeezelite-docker/blob/main/README.md) file.
Removed old build binaries|Previously quarantined files removed

### 2022-03-12

Feature|Description
:---|:---
Base Image Bump|Bump to debian buster-20220228-slim, debian bullseye-20220228-slim, ubuntu focal-20220302
Quarantined old build binaries|Moved to `old/bin`, will be removed soon if everything works properly

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
