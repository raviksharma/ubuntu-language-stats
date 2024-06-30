#!/usr/bin/bash

set -euo pipefail

main() {

  ARCHIVE=/var/spool/apt-mirror/mirror/archive.ubuntu.com/ubuntu/pool
  REPOSITORY=main

  for pkg in "${ARCHIVE}"/"${REPOSITORY}"/*/*
  do
    echo "${pkg}"
    if ls "${pkg}"/*.orig.tar.gz 1> /dev/null 2>&1; then
      echo "gz exists"
    elif ls "${pkg}"/*.orig.tar.xz 1> /dev/null 2>&1; then
      echo "xz exists"
    else
      echo "does not exists"
    fi   
  done
}

main "${@}"
