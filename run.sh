#!/bin/bash

if [ ! -d "/Users/$USER/Library/Containers/com.docker.docker/Data" ]; then
	echo "initializing docker... (press CTRL+C once if asked for password)"
	./init_docker.sh
fi;

echo "Waiting for Docker engine to be ready...";	\
until docker info &> /dev/null
do
    sleep 1
done
docker rm arch &> /dev/null
docker build --build-arg USER=$USER -t arch . && \
docker run --privileged -itv ~/:/home/$USER -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/docker/config.fish:/home/$USER/.config/fish/config.fish -e USER=$USER -e DEBUGINFOD_URLS="https://debuginfod.archlinux.org" -v /goinfre/$USER:/goinfre  -e DISPLAY=10.12.6.3:0 -p 8080:8080 --name arch arch 
