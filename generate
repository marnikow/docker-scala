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
# Generated automatically by generation script
# Do no edit this file

FROM openjdk:8-jdk

WORKDIR /tmp


### Install Requirements
ENV REQUIREMENTS apt-transport-https

RUN apt-get update --yes && \\
    apt-get install --yes --no-install-recommends \${REQUIREMENTS}


### Scala Installation
ENV SCALA_VERSION ${version}
ENV SCALA_PACKAGE scala-\${SCALA_VERSION}.deb

RUN wget --quiet "http://www.scala-lang.org/files/archive/\${SCALA_PACKAGE}" && \\
    dpkg --install \${SCALA_PACKAGE}


### SBT Installation
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \\
    echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list && \\
    apt-get update --yes && \\
    apt-get install --yes --no-install-recommends sbt && \\
    sbt -batch


### Cleaning
RUN rm /etc/apt/sources.list.d/sbt.list && \\
    apt-get purge --yes \${REQUIREMENTS} && \\
    apt-get clean && \\
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /tmp/*


VOLUME /app
WORKDIR /app
END

done
