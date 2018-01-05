#!/bin/bash

res="$(zcat /proc/config.gz 2>/dev/null | cat - /boot/config-`uname -r` 2>/dev/null)"

if [[ -z "$res" ]]; then
  echo "Uh well you don't have a config so... I don't know?"
  exit 0
fi

res="$(echo "$res" | grep CONFIG_PAGE_TABLE_ISOLATION)"

if [[ -z "$res" ]]; then
  echo "[!] Kernel not patched [!]"
  exit 0
fi

echo "Kernel is patched :)"

res="$(cat /proc/cpuinfo | grep bug | uniq | grep cpu_insecure)"
if [[ -z "$res" ]]; then
  echo "Good news! Your CPU is not vulnerable to Meltdown! :D"
  exit 0
fi

echo "Your CPU is vulnerable :( But at least you have the patch! :D"
