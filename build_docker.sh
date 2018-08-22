#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

REGISTRY="dockercentral.it.att.com:5100"
NAMESPACE="com.att.dev.argos"
IMAGE_NAME="centos7-python3-mod_wsgi"
TAG="3.6.6"

FULL_IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

docker login -u m12292@argos.dev.att.com -p 3W2-CDP-naF-3aN -e m12292@att.com ${REGISTRY}

docker build -t $FULL_IMAGE_NAME ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy
