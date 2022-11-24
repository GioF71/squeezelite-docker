# Asus Tinkerboard

## Docker errors

Currently (at least until circa November 2022, 24th), there is an issue with docker not running the squeezelite image (and of course a lot of others if not every single image). This can be solved running these commands as `root`:

```text
grep -q 'systemd.unified_cgroup_hierarchy=0' /boot/boot.cmd || G_EXEC sed -i '/^setenv bootargs "/s/"$/ systemd.unified_cgroup_hierarchy=0"/' /boot/boot.cmd
apt install u-boot-tools
mkimage -C none -A arm64 -T script -d /boot/boot.cmd /boot/boot.scr
```

A reboot is required after this command.
Reference: [here](https://github.com/MichaIng/DietPi/issues/5198) and more specifically this [reply](https://github.com/MichaIng/DietPi/issues/5198#issuecomment-1019510936).

## Audio quality

### Audio Quality Issue

I was experiencing bad audio quality after the upgrade to bullseye, with all sorts of disturbances. Click, pops, etc.

### Audio Quality Solution

Apparently, the problem is related to the cpu governor, and more specifically with the lowest possible cpu frequency. When set to a high(er) value, the issue disappears. I tried with good success by setting the minimum frequency to 1800 MHz (same as the max frequency), but I later tried with 1200 MHz as the minimum frequency without experiencing the issue. I do not know which would the lowest possible frequency that still works properly. I am quite happy right now with 1200 MHz.
The governor settings can be set using `dietpi-config`. See the screenshot [here](../img/tinkerboard-performance-settings-small.png).  

## NTP

### NTP Issue

This issue one is mostly related to mpd with a scrobbler. See [this](https://github.com/GioF71/mpd-alsa-docker) repository.
I was experiencing this issue:

```text
2022-11-18T21:22:28+0000 [last.fm] handshake failed, clock not synchronized (BADTIME)
2022-11-18T21:22:28+0000 [last.fm] waiting 60 seconds before trying again
2022-11-18T21:22:28+0000 [libre.fm] handshake failed, clock not synchronized (BADTIME)
2022-11-18T21:22:28+0000 [libre.fm] waiting 60 seconds before trying again
```

### NTP Solution

I solved the issue by changing the ntp governor to `Daemon + Drift`.
See the screenshot [here](../img/tinkerboard-ntp-settings-small.png).
