#! /bin/bash
#
# SCP Copy Deployment TAR for docker-compose
# =============================================================================
# Copy over a docker-compose.yml & scripts to start the container(s).
# =============================================================================

source ./deployment/configs.env

DEPLOY_HOST=$1
DEPLOY_DIR=$2

if [ -z "${DEPLOY_HOST}" ] || [ -z "${DEPLOY_DIR}" ]; then
    echo "Usage: $0 DEPLOY_HOST DEPLOY_DIR"
    echo
    exit 1
fi

echo
echo "Copy docker-compose Deployment: $IMAGE_TAG ..."

cd ${PROJECT_DIR}

tar -cvf deploy-${PROJECT_NAME}.tar  ../${PROJECT_NAME}/deployment/ ../${PROJECT_NAME}/docker-compose.yml
scp deploy-${PROJECT_NAME}.tar ${DEPLOY_HOST}:${DEPLOY_DIR}

SSH_CMD="/bin/bash -c \"cd ${DEPLOY_DIR} && tar -xf deploy-${PROJECT_NAME}.tar && cd ./${PROJECT_NAME} && ./deployment/deploy.sh\""
echo SSH_CMD ${SSH_CMD}
ssh ${DEPLOY_HOST} ${SSH_CMD}

cd -

echo "Deployed: $IMAGE_TAG"
echo
