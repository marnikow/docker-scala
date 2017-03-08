[![dockeri.co](http://dockeri.co/image/bigtruedata/scala)](https://hub.docker.com/r/bigtruedata/scala/)

# Supported tags and respective `Dockerfile` links
- [`2.12.1`,`latest`(2.12.1/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.12.1/Dockerfile)
- [`2.11.8`(2.11.8/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.11.8/Dockerfile)
- [`2.10.6`(2.10.6/Dockerfile)](https://github.com/bigtruedata/docker-scala/blob/master/2.10.6/Dockerfile)

This image may be used in a standalone fashion by defining the following aliases:
```sh
$ alias scala='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala'
$ alias scalac='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scalac'
$ alias scalap='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scalap'
$ alias scaladoc='docker run --rm --tty --interactive --volume $PWD:/app bigtruedata/scala scaladoc'
```
