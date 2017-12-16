#!/bin/bash

if [ -z "$(getent passwd docker)" ]; then
    useradd -g users -G sudo -u $DOCKER_UID -s /bin/bash -d $DOCKER_HOME -m docker
    echo "docker:docker" | chpasswd
fi