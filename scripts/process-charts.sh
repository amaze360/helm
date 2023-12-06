#!/bin/bash

# Loop through all chart directories
for d in */ ; do
  chart_name=$(basename "$d")
  chart_version=$(yq e '.version' "$d/Chart.yaml")

  image_tag=$(yq e '.image.tag' "$d/values.yaml") yq -i '.appVersion=env(image_tag)' "$d/Chart.yaml"   

  if [ ! -f "../public/$chart_name-$chart_version.tgz" ]; then
    helm package "$d" -d ../public
  else
    echo "Chart $chart_name-$chart_version already exists, skipping."
  fi
done