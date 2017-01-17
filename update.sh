#!/bin/bash

set -eo pipefail

declare -a versions=(
  2.12.1
  2.11.8
  2.10.6
)

for version in "${versions[@]}"
do
  rm -rf "$version"
  mkdir "$version"

  cat > "$version/Dockerfile" <<-END
# Generated automatically by update.sh
# Do no edit this file

FROM openjdk:8-alpine

# The bash shell is required by Scala utilities
RUN apk add --no-cache bash

# Install build dependencies
RUN apk add --no-cache --virtual=.dependencies tar

RUN wget -O- "http://downloads.lightbend.com/scala/$version/scala-$version.tgz" \\
    |  tar xzf - -C /usr/local --strip-components=1

# Remove build dependencies
RUN apk del --no-cache .dependencies
END

done
