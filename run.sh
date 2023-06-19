#!/bin/bash

# if [ ! $(docker info &> /dev/null) ]; then 				\
# 	~/docker/init_docker.sh;							\
# fi
echo "Waiting for Docker engine to be ready...";	\
until docker info &> /dev/null
do
    sleep 1
done
docker rm arch &> /dev/null
docker build --build-arg USER=$USER -t arch ~/docker
docker run --privileged -itv ~/:/home/$USER -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/docker/config.fish:/home/$USER/.config/fish/config.fish -e USER=$USER -e DEBUGINFOD_URLS="https://debuginfod.archlinux.org" -v /goinfre/mschlenz:/goinfre  -e DISPLAY=10.12.6.3:0 --name arch arch 

# -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $XDG_RUNTIME_DIR/$XAUTHORITY:$XDG_RUNTIME_DIR/$XAUTHORITY -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR 