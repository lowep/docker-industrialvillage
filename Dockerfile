FROM openjdk:17-slim

LABEL maintainer="your-name"

RUN apt-get update && apt-get install -y curl unzip

ENV MINECRAFT_VERSION=1.20.1
ENV FORGE_VERSION=47.2.14
ENV MODPACK_VERSION=1.6c

WORKDIR /data

COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/data"]

EXPOSE 25565

CMD ["/start.sh"]