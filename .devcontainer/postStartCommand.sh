#!/bin/bash

# Get Local workspace folder
localWorkspaceFolder=$1

pip3 install --user -r requirements.txt
git config --global --add safe.directory $localWorkspaceFolder
git config --global core.autocrlf true
git config core.fileMode false
xrandr -s 1920x1080