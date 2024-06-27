#!/bin/bash
# Entrypoint script that corrects permissions for files so that
# files are readable and writable
# Hacky workaround for Windows awfulness, based on
# https://github.com/docker/for-win/issues/2476#issuecomment-1295814591
chown -R me:me /home/me
# Change permissions of .ssh so that we can actually SSH into CSE
# Otherwise, `ssh` complains about bad permissions on the config and private
# keys
chmod 700 -R /home/me/.ssh
su --login me
