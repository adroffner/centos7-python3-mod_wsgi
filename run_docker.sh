#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Run docker image  in a new container.
# This is NOT run in "detached" (-d) mode.
# =============================================================================

REPOSITORY="att-gcs"
IMAGE_NAME="centos7-python3-mod_wsgi"
TAG="3.5.2"

IMAGE_TAG="${REPOSITORY}/${IMAGE_NAME}:${TAG}"

docker run --rm -ti -p 8001:8001 $IMAGE_TAG
