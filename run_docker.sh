#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Run docker image in a new container.
# This is NOT run in "detached" (-d) mode.
# =============================================================================

REGISTRY="dockercentral.it.example.com:5100"
NAMESPACE="com.example.dev.argos"
IMAGE_NAME="centos7-python3-mod_wsgi"
TAG="3.6.6"

FULL_IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

docker run --rm -ti -p 8001:8001 $FULL_IMAGE_NAME
