#!/usr/bin/bash
# An alias and function that I use with OpenSUSE.
function cleanup {
  local unneeded_packages
  unneeded_packages=$(zypper --non-interactive --quiet pa --unneeded | awk -F '|' 'NR>2 { print $3 }' - | tr '\n' ' ')
  if [[ $unneeded_packages ]]; then
    sudo zypper rm "$unneeded_packages"
  fi
}
function mountARCHRSBG {
  local efi
  local data
  efi=$(lsblk --json -b | jq -r '.blockdevices.[] | select(.children) | .children.[] | select(.size < pow(1024; 3)) | .name')
  data=$(lsblk --json -b | jq -r '.blockdevices.[] | select(.children) | .children.[] | select(.size > pow(1024; 3)) | .name')
  sudo cryptsetup --allow-discards --perf-no_read_workqueue --perf-no_write_workqueue --persistent open /dev/"$data" cryptroot
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@ /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@home /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/home
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@pkg /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/var/cache/pacman/pkg/
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@tmp /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/var/tmp/
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@srv /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/srv
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@snapshots /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/.snapshots/
  sudo mount -o compress=no,space_cache=v2,ssd,discard=async,subvol=@swap /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/.swapvol
  sudo mount -o noatime,nodiratime,compress=zstd,commit=120,space_cache=v2,ssd,discard=async,autodefrag,subvol=@btrfs /dev/mapper/cryptroot /home/rgarber11/ARCHRSBG/btrfs
  sudo mount /dev/"$efi" /home/rgarber11/ARCHRSBG/boot
}
function umountARCHRSBG {
  sudo umount /home/rgarber11/ARCHRSBG/boot/
  sudo umount /home/rgarber11/ARCHRSBG/btrfs/
  sudo umount /home/rgarber11/ARCHRSBG/.swapvol/
  sudo umount /home/rgarber11/ARCHRSBG/.snapshots/
  sudo umount /home/rgarber11/ARCHRSBG/srv/
  sudo umount /home/rgarber11/ARCHRSBG/var/tmp
  sudo umount /home/rgarber11/ARCHRSBG/var/cache/pacman/pkg/
  sudo umount /home/rgarber11/ARCHRSBG/home
  sudo umount /home/rgarber11/ARCHRSBG/
  sudo cryptsetup close cryptroot
}
alias update='sudo zypper dup && sudo zypper patch && sudo zypper up'
