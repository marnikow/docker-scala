#!/bin/bash

set -eo pipefail

declare -a versions=(
  2.12.2
  2.12.1
  2.11.8
  2.10.6
)

for version in "${versions[@]}"
do
  rm -rf "$version"

  cp -R base "$version"
  sed -e "s/<version>/$version/g" Dockerfile.template > "$version/Dockerfile"
done
