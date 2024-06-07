FROM ubuntu:latest

RUN apt update
# file, less, unzip, zip, git -- Core programs
# LLVM -- Clang C compiler + debug tools
# Make -- build system
# SSH -- connect to CSE
RUN apt -y install file less unzip zip llvm make ssh git

# Change to the 'ubuntu' user (created by the image)
USER ubuntu

# Give a nice bash config, with some helper commands
COPY --chown=ubuntu:ubuntu dot.bashrc /home/ubuntu/.bashrc
# Link their zID
COPY --chown=ubuntu:ubuntu ./config/zid /home/ubuntu/.zid


WORKDIR /home/ubuntu/work

CMD [ "bash" ]
