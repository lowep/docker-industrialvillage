# docker-industrialvillage

# Industrial-Village Minecraft Server Docker

This repository contains a Dockerfile for setting up a Minecraft server with the Industrial-Village modpack.

## Usage

To run the server:

```bash
docker run -d -it -p 25565:25565 -e MEMORY=4G -v /path/on/host:/data --name mc-server your-dockerhub-username/industrial-village-server:tag
