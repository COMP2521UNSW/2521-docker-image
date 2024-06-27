# Dockerfile
# This is the build script for creating the docker image.
#
# Author: Maddy Guthridge
FROM ubuntu:latest

RUN apt update
# CSE connection tools
RUN apt install -y ssh git rsync
# Build + debug tools
RUN apt install -y make llvm clang clangd
# Core programs (installed last, since they are most likely to change)
RUN apt install -y file less unzip zip time nano

# Change to the 'ubuntu' user (created by the image)
USER ubuntu

WORKDIR /home/ubuntu

CMD [ "bash" ]
