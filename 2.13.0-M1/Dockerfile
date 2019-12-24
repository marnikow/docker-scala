# Generated automatically by update.sh
# Do no edit this file

FROM openjdk:8

RUN wget -O- "https://scala-lang.org/files/archive/scala-2.13.0-M1.tgz" \
    | tar xzf - -C /usr/local --strip-components=1

VOLUME /app
WORKDIR /app

CMD ["scala"]
