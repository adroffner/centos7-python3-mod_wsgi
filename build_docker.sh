#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

REPOSITORY="att-gcs"
IMAGE_NAME="centos7-python3-mod_wsgi"
TAG="3.5.2"

IMAGE_TAG="${REPOSITORY}/${IMAGE_NAME}:${TAG}"

docker build -t $IMAGE_TAG ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy
