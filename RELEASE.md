# squeezeLite-Docker Release History

## Release

There is roughly a release for each entry of the following changelog. Older build might be dropped in order to save space on docker-hub and incur in limitations

## Changelog

### 2022-11-26

Date|Feature|Description
:---|:---|:---
2022-11-25|Update|Soureforge binaries version bump

### 2022-11-25

Date|Feature|Description
:---|:---|:---
2022-11-25|Improvement|Allow mixer device and volume control in presets

### 2022-11-24

Date|Feature|Description
:---|:---|:---
2022-11-24|Improvement|All presets moved to `builtin-presets.conf`

### 2022-11-06

Date|Feature|Description
:---|:---|:---
2022-11-06|Bug|Launching non-existing binary when trying to show available outputs

### 2022-11-05

Date|Feature|Description
:---|:---|:---
2022-11-05|Improvement|Removed duplicate code
2022-11-05|Build|Ubuntu `jammy` is `stable`, `kinetic` is `latest`
2022-11-05|Build|Add support for ubuntu kinetic

### 2022-11-04

Date|Feature|Description
:---|:---|:---
2022-11-04|Build|Multistage build

### 2022-11-01

Date|Feature|Description
:---|:---|:---
2022-11-01|Update|Upgraded sourceforge binary for armhf to 1411

### 2022-10-24

Date|Feature|Description
:---|:---|:---
2022-10-24|Improvement|Updated GitHub action versions
2022-10-13|Feature|User-level systemd service for pulseaudio renamed to squeezelite-pulse

### 2022-10-07

Date|Feature|Description
:---|:---|:---
2022-10-07|Feature|Support for logging levels

### 2022-10-02

Feature|Description
:---|:---
Build|Add apt proxy support
PulseAudio|Download/install both alsa and pulseaudio versions of squeezelite
PulseAudio|Support in sourceforge versions introduced

### 2022-09-28.1

Feature|Description
:---|:---
Build|Support for release, main, devel and feature tags
Presets|Add new preset for Gustard U12 DDC

### 2022-09-28

Feature|Description
:---|:---
Documentation|Fixed typos/Cleanup
Documentation|Track (new) image tags
Presets|Add new presets (Aune X12 & S6, Yulong D200, Peachtree DAC-iT)
Build|Only from tags (reduce number of builds)
Build|Build from main and devel branch only (no dates, no timestamps)
Build|Support for building releases from a `release` branch by pushing a tag `release/<release-version>`.

### 2022-09-27

Feature|Description
:---|:---
Documentation|PulseAudio mode works with images tagged as `latest`
Build|Build process reviewed
Build|Created special tags dictionary
Build|Avoid images with timestamps for devel and branch builds

### 2022-09-20

Feature|Description
:---|:---
Documentation|PulseAudio mode instructions are possibly clearer now
Bookwork support|Add build with debian bookworm (next stable release), using SqueezeLite version 1.9.9. Resulting images will be tagged as "edge" on Docker Hub
Tag changes|Apply `latest` and `stable` tags to `bullseye`, without sourgeforge binary
Tag changes|Apply `edge` tag to bookworm, without sourgeforge binary
Tag changes|Apply `legacy` tag to buster, without sourgeforge binary
Tag changes|Apply `sourceforge-legacy` tag to buster with sourceforge binary (if the image is generated)

### 2022-09-17

Feature|Description
:---|:---
Documentation|Fixed typo on PGID notes
Documentation|Mentioned PulseAudio early in Why section
PulseAudio/SystemD|Removed my custom player name from unit, now the player name reflects the hostname
PulseAudio/SystemD|Service now should wait for the network

### 2022-09-16

Feature|Description
:---|:---
Documentation|More documentation for PulseAudio mode
Cleanup|Fixed use of PUID and PGID

### 2022-09-15-pulse

Feature|Description
:---|:---
PulseAudio support|Initial PulseAudio support

### 2022-09-15

Feature|Description
:---|:---
Documentation update|Fixed docker hub tag documentation

### 2022-09-13

Feature|Description
:---|:---
Removed builds|Skipped buster with sourceforge binaries
Removed builds|Stable is bullseye with binaries from repositories

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
