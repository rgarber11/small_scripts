# Small Scripts

A collection of small programs I use on my system. Probably not useful for anybody, but copied for anyone's use.

1. **killdrive** My Eluktronics Mech 15-G3's Windows harddrive does not play well with linux. After sleep, it does not wake back up, and acts weird. This script gives a simple interface for `udev` rules to make sure it is not loaded up by default, allowing sleep to work correctly for me. If I want to transfer over something, I `killdrive -d` will disable it.
2. **Hyprnvidia** I use [Envycontrol](https://github.com/bayasdev/envycontrol) to manage Nvidia Optimus on my laptop. Usually, in integrated or hybrid mode, I don't want nvidia-specific Hyprland options, since they'll slow down and worsen my experience. When my laptop is in Nvidia-only mode (and Envycontrol generates the relevant X.org options) this script will load Nvidia related Hyprland files, enabling the WM to work.
