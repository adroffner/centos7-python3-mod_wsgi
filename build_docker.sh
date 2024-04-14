#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

## REGISTRY="dockercentral.it.example.com:5100/"
REGISTRY=""  # Docker Hub is implied.
NAMESPACE="com.example.dev"
IMAGE_NAME="centos7-python3-mod_wsgi"
TAG="3.8.r1"

DOCKERFILE=Dockerfile

FULL_IMAGE_NAME="${REGISTRY}${NAMESPACE}/${IMAGE_NAME}:${TAG}"

# Docker Registry Login
# =============================================================================
# Private Docker Registry requires a login but Docker Hub does not.
# =============================================================================
## docker login -u user@dev.example.com --password fake ${REGISTRY}

docker build -t $FULL_IMAGE_NAME ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    -f ${DOCKERFILE}
