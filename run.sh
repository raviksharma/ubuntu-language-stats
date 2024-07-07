#!/usr/bin/bash

set -euo pipefail

cleanup() {
  test -d "${tmp_dir}" && rm -rf "${tmp_dir}"
}

self=$(basename "$0")
tmp_dir=$(mktemp -d -t "${self}".XXXX)
echo "${tmp_dir}"

trap cleanup EXIT

main() {

  ARCHIVE=/var/spool/apt-mirror/mirror/archive.ubuntu.com/ubuntu/pool
  REPOSITORY=main

  for pkg in "${ARCHIVE}"/"${REPOSITORY}"/*/*
  do
    if ls "${pkg}"/*.orig.tar.gz 1> /dev/null 2>&1; then
      compressed_src=$(ls "${pkg}"/*.orig.tar.gz | sort | tail -n 1)
    elif ls "${pkg}"/*.orig.tar.xz 1> /dev/null 2>&1; then
      compressed_src=$(ls "${pkg}"/*.orig.tar.xz | sort | tail -n 1)
    elif ls "${pkg}"/*.orig.tar.bz2 1> /dev/null 2>&1; then
      compressed_src=$(ls "${pkg}"/*.orig.tar.bz2 | sort | tail -n 1)
    elif ls "${pkg}"/*.tar.xz 1> /dev/null 2>&1; then
      compressed_src=$(ls "${pkg}"/*.tar.xz | sort | tail -n 1)
    elif ls "${pkg}"/*.tar.gz 1> /dev/null 2>&1; then
      compressed_src=$(ls "${pkg}"/*.tar.gz | sort | tail -n 1)
    else
      echo "err: compressed src does not exist"
    fi

    pkg_name=$(basename "${pkg}")
    tmp_pkg_loc="${tmp_dir}"/"${pkg_name}"
    mkdir "${tmp_pkg_loc}"

    echo -n "${pkg_name}: "

    tar -xf "${compressed_src}" -C "${tmp_pkg_loc}" --strip-components 1
    # (cd "${tmp_pkg_loc}" && git init -q && git add . && git commit -q -m 'commit' && github-linguist -j)

  done
}

main "${@}"
