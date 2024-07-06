#!/usr/bin/bash

set -euo pipefail

main() {

  ARCHIVE=/var/spool/apt-mirror/mirror/archive.ubuntu.com/ubuntu/pool
  REPOSITORY=main

  RUNID=$(head -2 /dev/urandom | tr -cd '[:alnum:]' | head -c 4)
  echo "RUNID=${RUNID}"

  for pkg in "${ARCHIVE}"/"${REPOSITORY}"/*/*
  do
    echo -n "${pkg}: "
    if ls "${pkg}"/*.orig.tar.gz 1> /dev/null 2>&1; then
      echo "gz exists"
    elif ls "${pkg}"/*.orig.tar.xz 1> /dev/null 2>&1; then
      echo "xz exists"
    elif ls "${pkg}"/*.orig.tar.bz2 1> /dev/null 2>&1; then
      echo "bz2 exists"
    else
      echo "does not exists"
    fi   
  done
}

main "${@}"
