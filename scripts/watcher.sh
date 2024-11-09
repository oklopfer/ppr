#!/usr/bin/env bash

PASSPHRASE="${1:?PASSPHRASE is required}"

inotifywait -m -r ~/get -e create -e moved_to |
while read -r path action file; do
  distro="${path##*/}"
  echo "File received: ${distro}/${file} @ $(date +'%Y-%m-%d/%H:%M:%S')" >> ~/upload_log.txt
  aptly repo add -remove-files -force-replace ppr-"${distro}" "${path}${file}"
  aptly publish update -passphrase="${PASSPHRASE}" -batch pacstall
done