#!/usr/bin/bash

set -euo pipefail

cleanup() {
  test -d "${tmp_dir}" && rm -rf "${tmp_dir}"
}

self=$(basename "$0")
tmp_dir=$(mktemp -d -t "${self}".XXXX)
echo "${tmp_dir}"

trap cleanup ERR EXIT

main() {

  ARCHIVE=/var/spool/apt-mirror/mirror/archive.ubuntu.com/ubuntu/pool
  REPOSITORY=main

  for pkg in "${ARCHIVE}"/"${REPOSITORY}"/libn/libn*
  do
    pkg_name=$(basename "${pkg}")
    tmp_pkg_loc="${tmp_dir}"/"${pkg_name}"

    echo -n "${pkg_name}: "

    #echo $(basename "${compressed_src}")
    dpkg-source -q -x "${pkg}"/*.dsc "${tmp_pkg_loc}"
    (cd "${tmp_pkg_loc}" && git init -q && git add . && git commit -q -m 'commit' && github-linguist -j)

  done
}

main "${@}"
