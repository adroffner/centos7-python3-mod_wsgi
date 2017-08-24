#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

source ./deployment/configs.env

echo
echo "Building Docker image: $IMAGE_TAG ..."

docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

docker build -t $IMAGE_TAG \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    ./

docker logout ${REGISTRY}

echo "DONE: $IMAGE_TAG"
echo
