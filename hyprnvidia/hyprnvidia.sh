#!/bin/bash

if test -f /etc/X11/xorg.conf.d/10-nvidia.conf; then
    printf '%s\n' 'env = LIBVA_DRIVER_NAME,nvidia' 'env = XDG_SESSION_TYPE,wayland' 'env = GBM_BACKEND,nvidia-drm' 'env = __GLX_VENDOR_LIBRARY_NAME,nvidia' 'cursor {' 'use_cpu_buffer = true' '}' >/home/rgarber11/.config/hypr/nvidia.conf
else
    echo "" >/home/rgarber11/.config/hypr/nvidia.conf
fi
