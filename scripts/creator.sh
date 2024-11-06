#!/usr/bin/env bash

PASSPHRASE="${1:?PASSPHRASE is required}"
distrolist=("ubuntu-latest" "ubuntu-develop" "ubuntu-rolling" "debian-stable" "debian-testing" "debian-unstable")
archlist=("amd64" "arm64" "source")
mapfile -t pprlist < <(printf 'ppr-%s\n' "${distrolist[@]}")
distrostring="$(IFS=,; echo "${distrolist[*]}")"
archstring="$(IFS=,; echo "${archlist[*]}")"

for i in "${distrolist[@]}"; do
  aptly repo create -distribution=pacstall -component="${i}" "ppr-${i}"
done

aptly publish repo -component="${distrostring}" -architectures="${archstring}" -passphrase="${PASSPHRASE}" "${pprlist[@]}"
