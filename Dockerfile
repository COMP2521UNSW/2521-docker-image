# Dockerfile
# This is the build script for creating the docker image.
#
# Author: Maddy Guthridge
FROM ubuntu:latest

# Remove the ubuntu user to prevent uid clashes on Linux
# https://bugs.launchpad.net/cloud-images/+bug/2005129/comments/2
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu

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
