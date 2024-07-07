#!/usr/bin/bash

set -euo pipefail

cleanup() {
  test -d "${tmp_dir}" && rm -fr "${tmp_dir}"
}

me=$(basename "$0")
tmp_dir=$(mktemp -d -t "${me}".XXXX)
echo "${tmp_dir}"

trap cleanup EXIT

main() {

  ARCHIVE=/var/spool/apt-mirror/mirror/archive.ubuntu.com/ubuntu/pool
  REPOSITORY=main

  for pkg in "${ARCHIVE}"/"${REPOSITORY}"/*/*
  do
    echo -n "${pkg}: "
    if ls "${pkg}"/*.orig.tar.gz 1> /dev/null 2>&1; then
      echo "orig gz exists"
    elif ls "${pkg}"/*.orig.tar.xz 1> /dev/null 2>&1; then
      echo "orig xz exists"
    elif ls "${pkg}"/*.orig.tar.bz2 1> /dev/null 2>&1; then
      echo "orig bz2 exists"
    elif ls "${pkg}"/*.tar.xz 1> /dev/null 2>&1; then
      echo "some xz exists"
    elif ls "${pkg}"/*.tar.gz 1> /dev/null 2>&1; then
      echo "some gz exists"
    else
      echo "does not exists"
    fi   
  done
}

main "${@}"
