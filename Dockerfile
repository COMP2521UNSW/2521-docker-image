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
RUN apt install -y file less unzip zip time nano bat vim

# Copy entrypoint script
COPY "container-scripts/fix-permissions.sh" "/root/fix-permissions.sh"

# Create, then switch to "me" user, where students can do their work
RUN groupadd -g ${GID} -o "me"
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash "me"
USER me
WORKDIR /home/me

# Now leave it doing nothing
CMD [ "sleep", "infinity" ]
