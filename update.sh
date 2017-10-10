#!/bin/bash

set -eo pipefail

declare -a versions=(
    2.12.3
    2.11.11
    2.10.6
)

generate_standard() {
  sed -e "s/<version>/$1/g" dockerfile/standard.template > "$1/Dockerfile"
}

generate_alpine() {
  cp -R base/alpine "$1/alpine"
  sed -e "s/<version>/$1/g" dockerfile/alpine.template > "$1/alpine/Dockerfile"
}

for version in "${versions[@]}"
do
  rm -rf "${version}"
  mkdir "${version}"
  
  generate_standard "${version}"
  generate_alpine "${version}"
done
