#!/bin/bash

# Loop through all chart directories
for d in */ ; do
  chart_name=$(basename "$d")
  chart_version=$(grep 'version:' "$d/Chart.yaml" | awk '{ print $2 }')

  if [ ! -f "../public/$chart_name-$chart_version.tgz" ]; then
    helm dependency update "$d"
    helm package "$d" -d ../public
  else
    echo "Chart $chart_name-$chart_version already exists, skipping."
  fi
done