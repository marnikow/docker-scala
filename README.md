# The [`bigtruedata/scala`](https://hub.docker.com/r/bigtruedata/scala/) image

[![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/u/sourceworks/)
[![Docker Pulls](https://img.shields.io/docker/pulls/bigtruedata/scala.svg)](https://hub.docker.com/r/bigtruedata/scala/)
[![Docker Stars](https://img.shields.io/docker/stars/bigtruedata/scala.svg)](https://hub.docker.com/r/bigtruedata/scala/)
[![Build Status](https://travis-ci.org/bigtruedata/docker-scala.svg?branch=master)](https://travis-ci.org/bigtruedata/docker-scala)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository contains the build files to generate Docker images that provide the Scala environment. The scala environment is currently composed by the commands _scala_, _scalac_, _scalap_, and _scaladoc_.

This image may be used in a standalone fashion by defining the following aliases:
```sh
$ alias scala='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scala'
$ alias scalac='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scalac'
$ alias scalap='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scalap'
$ alias scaladoc='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scaladoc'
```
