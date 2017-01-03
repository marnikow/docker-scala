# The [`sourceworks/scala`](https://hub.docker.com/r/sourceworks/scala/) Docker image

[![Build Status](https://travis-ci.org/sourceworks/docker-scala.svg?branch=master)](https://travis-ci.org/sourceworks/docker-scala) [![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/u/sourceworks/)

This repository contains the build files to generate Docker images
that provide the Scala environment and the SBT tool. The scala
environment is currently composed by the commands _scala_, _scalac_, and
_scaladoc_.

This image may be used in a standalone fashion by defining the following
aliases:

```sh
$ alias scala='docker run --rm --tty --interactive --volume $PWD:/app sourceworks/scala scala'
$ alias scalac='docker run --rm --tty --interactive --volume $PWD:/app sourceworks/scala scalac'
$ alias scaladoc='docker run --rm --tty --interactive --volume $PWD:/app sourceworks/scala scaladoc'
```
