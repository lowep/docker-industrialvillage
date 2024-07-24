FROM openjdk:17-slim

LABEL maintainer="lowep29"

RUN apt-get update && apt-get install -y curl unzip dos2unix

ENV MINECRAFT_VERSION=1.20.1
ENV FORGE_VERSION=47.2.14
ENV MODPACK_VERSION=IV-1.20.1-Serverpack-1.6c

WORKDIR /app

COPY start.sh /app/start.sh

# Convert CRLF to LF
RUN dos2unix /app/start.sh && chmod +x /app/start.sh

RUN mkdir /data
VOLUME ["/data"]

EXPOSE 25565

CMD ["/bin/bash", "/app/start.sh"]
