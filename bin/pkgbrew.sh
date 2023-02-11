#!/bin/sh

installed_packages="$(brew list --formula | tr '\n' ' ')"
installed_casks="$(brew list --casks | tr '\n' ' ')"


check_pkg() {
    if echo "$installed_packages" | grep -q "$1"; then
        echo "$1 is already installed"
    else
        return 1
    fi
}

check_cask() {
    if echo "$installed_casks" | grep -q "$1"; then
        echo "$1 is already installed"
    else
        return 1
    fi
}

check_pkg cask || echo brew install cask

# Read the list of packages from the file
while read package; do
  # Check if the package is a cask
  if [[ $package == cask:* ]]; then
    # Install the cask
    check_cask "${package#cask:}" || brew install --cask "${package#cask:}"
  else
    # Install the package
    check_pkg "$package" || brew install "$package"
  fi
done < pkgbrew.txt

# To make a list:
# Forumlas: for f in $(brew list --formula | tr '\n' ' '; do   echo "$f"; done
# Casks: for f in $(brew list --casks | tr '\n' ' '; do   echo "$f"; done
