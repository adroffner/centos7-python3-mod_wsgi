#! /bin/bash
#
# Deploy Docker Image(s) using docker-compose
# =============================================================================
# Download & deploy one or more images using a docker-compose.yml definition.
# =============================================================================

source ./deployment/configs.env

# Pass docker-compose TIER as a parameter:
TIER=$1
case $TIER in
    dev|stage|prod)
        if [ ! -f "./docker-compose-${TIER}.yml" ]; then
            echo "Deployment Missing: docker-compose-${TIER}.yml"
            echo
            exit 1
        fi
        ;;

    *)
        echo "Usage: $0 dev|stage|prod"
        echo
        exit 1
        ;;
esac

echo
echo "Deploying Docker image: $IMAGE_TAG ..."

cd ${PROJECT_DIR}

# Rewrite docker-compose-*.yml to use the current version tag:
export TAG
perl -pi -e 's/:\$TAG$/:$ENV{TAG}/;' docker-compose-${TIER}.yml

sudo docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

sudo docker-compose -f docker-compose-${TIER}.yml pull web
sudo docker-compose -f docker-compose-${TIER}.yml down
sudo docker-compose -f docker-compose-${TIER}.yml up -d

sudo docker logout ${REGISTRY}

cd -

echo "Deployed: $IMAGE_TAG"
echo
