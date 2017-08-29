#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Delete previous local containers and images to save disc space.
# =============================================================================

source ./deployment/configs.env

echo
echo "Deleting earlier Docker containers and images for $IMAGE_TAG ..."

# Containers first (they depend on images)
EXITED_IDS=$(sudo docker ps -a -f status=exited | grep ${IMAGE_TAG%:*} | awk '{print $1}')
if [ -n "${EXITED_IDS}" ]; then
    sudo docker rm $EXITED_IDS
fi

# Match all related images except the current TAG, plus <none> (dangling=true):
IMAGE_OLD_IDS=$(sudo docker images | grep ${IMAGE_TAG%:*} | grep -v ${IMAGE_TAG##*:} | awk '{print $3}')
IMAGE_DANGLING_IDS=$(sudo docker images -q -f "dangling=true")
if [ -n "${IMAGE_OLD_IDS}" ] || [ -n "${IMAGE_DANGLING_IDS}" ]; then
    sudo docker rmi $IMAGE_OLD_IDS $IMAGE_DANGLING_IDS
fi

echo "Cleaned Up: $IMAGE_TAG"
echo
