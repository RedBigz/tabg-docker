FROM ubuntu:focal

# Dependencies
RUN apt-get update \
    && apt-get install -y unzip wget software-properties-common

RUN useradd -ms /bin/bash tabg

# Install SteamCMD (https://developer.valvesoftware.com/wiki/SteamCMD)
RUN add-apt-repository multiverse \
    && dpkg --add-architecture i386 \
    && apt-get update

RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

RUN apt-get install -y steamcmd

USER tabg

WORKDIR /tabg-server

# Install TABG
RUN /usr/games/steamcmd +force_install_dir /tabg-server +login anonymous +app_update 2311970 validate +exit

RUN chmod +x TABG.exe

# Install BepInEx
RUN wget -O /tmp/bepinex.zip https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.2/BepInEx_linux_x64_5.4.23.2.zip \
    && unzip /tmp/bepinex.zip -d . \
    && mkdir -p BepInEx/plugins/usr

# Install CitrusLib
RUN wget -O BepInEx/plugins/Citruslib.dll https://github.com/CyrusTheLesser/Citruslib/releases/download/v0.7/Citruslib.dll

ENTRYPOINT [ "./TABG.exe" ]