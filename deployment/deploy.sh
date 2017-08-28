#! /bin/bash
#
# Deploy Docker Image(s) using docker-compose
# =============================================================================
# Download & deploy one or more images using a docker-compose.yml definition.
# =============================================================================

source ./deployment/configs.env

echo
echo "Deploying Docker image: $IMAGE_TAG ..."

cd ${PROJECT_DIR}

sudo docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

sudo docker-compose pull web
sudo docker-compose down
sudo docker-compose up -d

sudo docker logout ${REGISTRY}

cd -

echo "Deployed: $IMAGE_TAG"
echo
