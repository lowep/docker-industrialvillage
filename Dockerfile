FROM openjdk:17-slim

LABEL maintainer="lowep29"

RUN apt-get update && apt-get install -y curl unzip

ENV MINECRAFT_VERSION=1.20.1
ENV FORGE_VERSION=47.2.14
ENV MODPACK_VERSION=1.6c

WORKDIR /data

# Copy start.sh and set permissions
COPY start.sh /data/start.sh
RUN chmod +x /data/start.sh

VOLUME ["/data"]

EXPOSE 25565

# Use full path and shell to execute
CMD ["/bin/sh", "/data/start.sh"]
