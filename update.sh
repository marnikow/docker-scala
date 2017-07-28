#!/bin/bash

set -eo pipefail

declare -a versions=(
  2.12.3
  2.12.2
  2.12.1
  2.12.0
  2.11.11
  2.11.10
  2.11.9
  2.11.8
  2.10.6
  2.10.5
  2.10.4
  2.10.3
)

for version in "${versions[@]}"
do
  rm -rf "$version"

  cp -R base "$version"
  sed -e "s/<version>/$version/g" Dockerfile.template > "$version/Dockerfile"
done
