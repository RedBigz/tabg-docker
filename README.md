# TABG Dedicated Server Docker

A docker image for TABG's dedicated server.

## Usage

```sh
docker build -t tabg-server .
docker-compose up -d
```

Note: You will need to give your folder write permissions! Make sure you keep read perms on the plugins folder just in case someone hacks into your server and tries to add a BepInEx plugin to escalate permissions to you.