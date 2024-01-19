#!/bin/bash

if [[ "$BUILD_MODE" == "r2" ]]; then
    echo "Removing packages for Squeezelite R2"
    apt-get remove -y git build-essential
    apt-get autoremove -y
fi