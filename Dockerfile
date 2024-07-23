FROM openjdk:17-slim

LABEL maintainer="lowep29"

RUN apt-get update && apt-get install -y curl unzip

ENV MINECRAFT_VERSION=1.19.2
ENV FORGE_VERSION=43.2.8
ENV MODPACK_VERSION=1.0.6

# Set the working directory to /app
WORKDIR /app

# Copy start.sh into the container at /app
COPY start.sh /app/start.sh

# Make sure the script is executable
RUN chmod +x /app/start.sh

# Create a data directory
RUN mkdir /data

# Set up a volume for /data
VOLUME ["/data"]

# Expose the Minecraft port
EXPOSE 25565

# Run start.sh when the container launches
CMD ["/app/start.sh"]
