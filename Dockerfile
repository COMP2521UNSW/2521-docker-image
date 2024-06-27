# Dockerfile
# This is the build script for creating the docker image.
#
# Author: Maddy Guthridge
FROM ubuntu:latest

ARG UID=1000
ARG GID=1000

RUN apt update
# CSE connection tools
RUN apt install -y ssh git rsync
# Build + debug tools
RUN apt install -y make llvm clang clangd
# Core programs (installed last, since they are most likely to change)
RUN apt install -y file less unzip zip time nano

RUN groupadd -g ${GID} -o "me"
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash "me"

# Copy entrypoint script
COPY "entrypoint.sh" "/root/entrypoint.sh"

# Run entrypoint script
CMD [ "sleep", "infinity" ]
