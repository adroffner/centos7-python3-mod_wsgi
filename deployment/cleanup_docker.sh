#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Delete previous local containers and images to save disc space.
# =============================================================================

source ./deployment/configs.env

echo
echo "Deleting earlier Docker containers and images for $IMAGE_TAG ..."

sudo docker rm $(sudo docker ps -a -f status=exited | grep ${IMAGE_TAG%:*} | awk '{print $1}')
sudo docker rmi $(sudo docker images | grep ${IMAGE_TAG%:*} | grep -v ${IMAGE_TAG##*:} | awk '{print $3}')
sudo docker rmi $(sudo docker images -q -f "dangling=true")

echo "Cleaned Up: $IMAGE_TAG"
echo
