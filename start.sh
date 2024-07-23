#!/bin/bash

set -x

cd /data

if ! [[ -f Industrial-Village-$MODPACK_VERSION.zip ]]; then
  curl -Lo Industrial-Village-$MODPACK_VERSION.zip https://mediafilez.forgecdn.net/files/4553/52/Industrial-Village-$MODPACK_VERSION.zip
  unzip -u -o Industrial-Village-$MODPACK_VERSION.zip -d /data/
fi

if ! [[ -f forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar ]]; then
  curl -o forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar https://maven.minecraftforge.net/net/minecraftforge/forge/$MINECRAFT_VERSION-$FORGE_VERSION/forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar
  java -jar forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar --installServer
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi

if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

if [[ -n "$WHITELIST" ]]; then
    echo $WHITELIST | awk -v RS=, '{print}' >> whitelist.txt
fi

if [[ -n "$ICON" ]]; then
    echo $ICON | base64 -d > server-icon.png
fi

if [[ -n "$RCON_PASSWORD" ]]; then
    echo "rcon.password=$RCON_PASSWORD" >> /data/server.properties
fi

if [[ -n "$LEVEL_SEED" ]]; then
    sed -i "/level-seed\s*=/ c level-seed=$LEVEL_SEED" /data/server.properties
fi

if [[ -n "$DIFFICULTY" ]]; then
    sed -i "/difficulty\s*=/ c difficulty=$DIFFICULTY" /data/server.properties
fi

if [[ -n "$GAMEMODE" ]]; then
    sed -i "/gamemode\s*=/ c gamemode=$GAMEMODE" /data/server.properties
fi

if [[ -n "$MAX_PLAYERS" ]]; then
    sed -i "/max-players\s*=/ c max-players=$MAX_PLAYERS" /data/server.properties
fi

if [[ -n "$MAX_WORLD_SIZE" ]]; then
    sed -i "/max-world-size\s*=/ c max-world-size=$MAX_WORLD_SIZE" /data/server.properties
fi

if [[ -n "$ALLOW_NETHER" ]]; then
    sed -i "/allow-nether\s*=/ c allow-nether=$ALLOW_NETHER" /data/server.properties
fi

if [[ -n "$ANNOUNCE_PLAYER_ACHIEVEMENTS" ]]; then
    sed -i "/announce-player-achievements\s*=/ c announce-player-achievements=$ANNOUNCE_PLAYER_ACHIEVEMENTS" /data/server.properties
fi

if [[ -n "$ENABLE_COMMAND_BLOCK" ]]; then
    sed -i "/enable-command-block\s*=/ c enable-command-block=$ENABLE_COMMAND_BLOCK" /data/server.properties
fi

if [[ -n "$FORCE_GAMEMODE" ]]; then
    sed -i "/force-gamemode\s*=/ c force-gamemode=$FORCE_GAMEMODE" /data/server.properties
fi

if [[ -n "$GENERATE_STRUCTURES" ]]; then
    sed -i "/generate-structures\s*=/ c generate-structures=$GENERATE_STRUCTURES" /data/server.properties
fi

if [[ -n "$HARDCORE" ]]; then
    sed -i "/hardcore\s*=/ c hardcore=$HARDCORE" /data/server.properties
fi

if [[ -n "$MAX_BUILD_HEIGHT" ]]; then
    sed -i "/max-build-height\s*=/ c max-build-height=$MAX_BUILD_HEIGHT" /data/server.properties
fi

if [[ -n "$MAX_TICK_TIME" ]]; then
    sed -i "/max-tick-time\s*=/ c max-tick-time=$MAX_TICK_TIME" /data/server.properties
fi

if [[ -n "$SPAWN_ANIMALS" ]]; then
    sed -i "/spawn-animals\s*=/ c spawn-animals=$SPAWN_ANIMALS" /data/server.properties
fi

if [[ -n "$SPAWN_MONSTERS" ]]; then
    sed -i "/spawn-monsters\s*=/ c spawn-monsters=$SPAWN_MONSTERS" /data/server.properties
fi

if [[ -n "$SPAWN_NPCS" ]]; then
    sed -i "/spawn-npcs\s*=/ c spawn-npcs=$SPAWN_NPCS" /data/server.properties
fi

if [[ -n "$VIEW_DISTANCE" ]]; then
    sed -i "/view-distance\s*=/ c view-distance=$VIEW_DISTANCE" /data/server.properties
fi

if [[ -n "$MEMORY" ]]; then
    sed -i "s/-Xmx[^ ]*/-Xmx$MEMORY/" user_jvm_args.txt
    sed -i "s/-Xms[^ ]*/-Xms$MEMORY/" user_jvm_args.txt
fi

if [[ -n "$ONLINE_MODE" ]]; then
    sed -i "/online-mode\s*=/ c online-mode=$ONLINE_MODE" /data/server.properties
fi

if [[ -n "$ALLOW_FLIGHT" ]]; then
    sed -i "/allow-flight\s*=/ c allow-flight=$ALLOW_FLIGHT" /data/server.properties
fi

if ! [[ $(ls -A mods) ]]; then
  echo "Installing mods..."
  mv -f *.jar mods/
fi

if ! [[ -f eula.txt ]]; then
  echo "eula=true" > eula.txt
fi

if [[ -n "$JVM_OPTS" ]]; then
  sed -i "/^-Xm[s,x]/d" user_jvm_args.txt
  echo $JVM_OPTS | tr " " "\n" >> user_jvm_args.txt
fi

exec java @user_jvm_args.txt @libraries/net/minecraftforge/forge/$MINECRAFT_VERSION-$FORGE_VERSION/unix_args.txt "$@"