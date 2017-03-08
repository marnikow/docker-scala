[![dockeri.co](http://dockeri.co/image/bigtruedata/scala)](https://hub.docker.com/r/bigtruedata/scala/)

# Supported tags and respective `Dockerfile` links
- [`2.12.1`,`latest`(2.12.1/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.12.1/Dockerfile)
- [`2.11.8`(2.11.8/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.11.8/Dockerfile)
- [`2.10.6`(2.10.6/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.10.6/Dockerfile)

# Quick Start
This image provides an specific version of the Scala environment. It consists of the Scala REPL (_scala_), the Scala compiler (_scalac_), the Scala class file decoder (_scalap_), and the Scala documentation generation tool (_scaladoc_). If not specified any command to execute the `bigtruedata/scala` image (as specified int the follogin example), the Scala REPL will be launched.

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
