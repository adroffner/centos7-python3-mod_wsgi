#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

REGISTRY="zlp11313.vci.att.com:5100"
NAMESPACE="com.att.dev.argos"
IMAGE_NAME="centos7-python3-mod_wsgi"
# TAG="3.5.2"
TAG="latest"

IMAGE_TAG="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

docker login -u m12292@argos.dev.att.com -p D4t4b4s3 -e m12292@att.com ${REGISTRY}

docker build -t $IMAGE_TAG ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy
