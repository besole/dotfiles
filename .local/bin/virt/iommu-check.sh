#!/bin/bash
shopt -s nullglob
for g in $( ls /sys/kernel/iommu_groups/ | sort -n ); do
  echo "IOMMU Group ${g##*/}:"
  for d in /sys/kernel/iommu_groups/$g/devices/*; do
    echo -e "\t$(lspci -nns ${d##*/})"
  done;
done;
