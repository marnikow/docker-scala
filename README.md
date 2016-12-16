# The [`sourceworks/scala`](https://hub.docker.com/r/sourceworks/scala/) Docker image

[![Build Status](https://travis-ci.org/sourceworks/docker-scala.svg?branch=master)](https://travis-ci.org/sourceworks/docker-scala) [![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/u/sourceworks/)

This repository contains the build files to generate Docker images containing a basic Scala environment.

## How to use this image

### Examples

```sh
$ docker run --rm --tty --interactive --volume $PWD:/app sourceworks/scala <command> <option>
```

where _<command>_ is one of _scala_, _scalac_, _scaladoc_, or _scalap_
and _<options>_ are the command-line options accepted by the command
being uded.
