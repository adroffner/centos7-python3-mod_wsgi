#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

source ./deployment/configs.env

echo
echo "Building Docker image: $IMAGE_TAG ..."

sudo docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

sudo docker build -t $IMAGE_TAG \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    ./
sudo docker push $IMAGE_TAG

sudo docker logout ${REGISTRY}

./deployment/cleanup_docker.sh

echo "DONE: $IMAGE_TAG"
echo
