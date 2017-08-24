#! /bin/bash
#
# Deploy Docker Image(s) using docker-compose
# =============================================================================
# Download & deploy one or more images using a docker-compose.yml definition.
# =============================================================================

source ./deployment/configs.env

# Pass env. vars to docker-compose as needed:
export TAG
export IP_SYSLOG

echo
echo "Deploying Docker image: $IMAGE_TAG ..."

cd ${PROJECT_DIR}

docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

docker-compose pull web
docker-compose down
docker-compose up -d

docker logout ${REGISTRY}

cd -

echo "Deployed: $IMAGE_TAG"
echo
