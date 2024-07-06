#!/bin/bash
# fix-permissions.sh
#
# Placed at /root/fix-permissions.sh
#
# Entrypoint script that corrects permissions for files so that
# files are readable and writable.
# Should be run as root within the container.
# Hacky workaround for Windows awfulness, based on
# https://github.com/docker/for-win/issues/2476#issuecomment-1295814591

# Make sure the "me" user owns its data
chown -R me:me /home/me

# Change permissions of .ssh so that we can actually SSH into CSE
# Otherwise, `ssh` complains about bad permissions on the config and private
# keys
chmod 700 -R /home/me/.ssh
