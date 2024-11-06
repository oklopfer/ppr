#!/usr/bin/env bash

path="${1}"
distro="${path%/*}"
distro="${distro##*/}"
file="${path##*/}"

echo "File received: ${distro}/${file} @ $(date +'%Y-%m-%d/%H:%M:%S')" >> ~/upload_log.txt
aptly repo add -remove-files -force-replace ppr-"${distro}" "${path}"
aptly publish update pacstall