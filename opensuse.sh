#!/usr/bin/bash
# An alias and function that I use with OpenSUSE.
function cleanup {
  local unneeded_packages
  unneeded_packages=$(zypper --non-interactive --quiet pa --unneeded | awk -F '|' 'NR>2 { print $3 }' - | tr '\n' ' ')
  if [[ $unneeded_packages ]]; then
    sudo zypper rm "$unneeded_packages"
  fi
}
alias update='sudo zypper dup && sudo zypper patch && sudo zypper up'
