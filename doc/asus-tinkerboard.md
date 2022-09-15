# Asus Tinkerboard

I was experiencing bad audio quality after the upgrade to bullseye.  
See [here](https://github.com/MichaIng/DietPi/issues/5198) and [here](https://github.com/MichaIng/DietPi/issues/4980) for a few references.  
I ended up downgrading the kernel to the legacy version with the following:

```code
sudo apt install linux-image-legacy-rockchip
```

Also, I changed the file `/boot/armbianEnv.txt` so that `extraargs` is set like the following:

```text
extraargs="net.ifnames=0" systemd.unified_cgroup_hierarchy=0
```

The file must be edited using `sudo`, and of course a reboot is required.  
And now, for my hearing capabilities, the audio quality is excellent.  
If anyone can suggest a more elegant solution, I will be happy to try it and then update this page.

