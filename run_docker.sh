#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Run docker image  in a new container.
# This is NOT run in "detached" (-d) mode.
# =============================================================================

source ./deployment/configs.env

# NOTE: The --log-driver=* and other logging flags must be to the left (before) the Docker container name (or ID).
docker run --rm -ti -p 8001:8001 \
    --log-driver=syslog --log-opt syslog-address=udp://localhost:514 --log-opt syslog-facility=user \
    $IMAGE_TAG
