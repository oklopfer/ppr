#!/usr/bin/env bash

inotifywait -m -r ~/get -e create -e moved_to |
while read -r path action file; do
  ~/handler.sh "${path}${file}"
done
