![Docker Automated buil](https://img.shields.io/docker/automated/bigtruedata/scala.svg?style=plastic)
![Docker Build Statu](https://img.shields.io/docker/build/bigtruedata/scala.svg?style=plastic)
![Docker Pulls](https://img.shields.io/docker/pulls/bigtruedata/scala.svg?style=plastic)
![Docker Stars](https://img.shields.io/docker/stars/bigtruedata/scala.svg?style=plastic)
![license](https://img.shields.io/github/license/bigtruedata/docker-scala.svg?style=plastic)

# [Scala Docker Image](https://hub.docker.com/r/bigtruedata/scala/)

## Supported tags and respective `Dockerfile` links
- [`2.12.2`,`2.12`,`latest`(2.12.2/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.12.2/Dockerfile)
- [`2.12.1`(2.12.1/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.12.1/Dockerfile)
- [`2.11.11`,`2.11`(2.11.11/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.11.11/Dockerfile)
- [`2.11.8`(2.11.8/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.11.8/Dockerfile)
- [`2.10.6`,`2.10`(2.10.6/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.10.6/Dockerfile)

---

![logo](https://raw.githubusercontent.com/bigtruedata/docker-scala/master/logo.png)

Scala is an acronym for “Scalable Language”. This means that Scala grows with you. You can play with it by typing one-line expressions and observing the results. But you can also rely on it for large mission critical systems.

> [scala-lang.org](http://scala-lang.org/)

## Quick Start
This image provides an specific version of the Scala environment. It consists of the Scala REPL (_scala_), the Scala compiler (_scalac_), the Scala class file decoder (_scalap_), and the Scala documentation generation tool (_scaladoc_). If not specified any command to execute the `bigtruedata/scala` image (as specified in the following example), the Scala REPL will be launched.

```sh
docker run --rm --tty --interactive bigtruedata/scala
```

This image can also be use in a standalone fashion the same way as if the environment was directly installed in the local machine. You just need to provide the path to the directory contained the source files to work with and the command to be executed. To avoid writting tons of commands, the following aliases may be handy:

```sh
alias scala='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala'
alias scalac='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scalac'
alias scalap='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scalap'
alias scaladoc='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scaladoc'
```

## Versions
This image is based on the [`openjdk:8-alpine`](https://hub.docker.com/_/openjdk/) image to provide the Java installation required by the Scala environment. The different versions of this image correspond tho the released versions of Scala that can be downloaded from the [Scala downloads](http://scala-lang.org/download/all.html) website.
