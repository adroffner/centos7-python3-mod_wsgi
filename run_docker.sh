#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Run docker image  in a new container.
# This is NOT run in "detached" (-d) mode.
# =============================================================================

REGISTRY="zlp11313.vci.att.com:5100"
NAMESPACE="com.att.dev.argos"
IMAGE_NAME="centos7-python3-mod_wsgi"
# TAG="3.5.2"
TAG="latest"

IMAGE_TAG="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

# NOTE: The --log-driver=* and other logging flags must be to the left (before) the Docker container name (or ID).
docker run --rm -ti -p 8001:8001 \
    --log-driver=syslog --log-opt syslog-address=unixgram:///dev/log --log-opt syslog-facility=user \
    $IMAGE_TAG
