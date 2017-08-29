#! /bin/bash
#
# SCP Copy Build TAR from Git archive
# =============================================================================
# Copy over a git archive TAR & scripts to build the image.
# =============================================================================

source ./deployment/configs.env

BUILD_HOST=$1
BUILD_DIR=$2

if [ -z "${BUILD_HOST}" ] || [ -z "${BUILD_DIR}" ]; then
    echo "Usage: $0 BUILD_HOST BUILD_DIR"
    echo
    exit 1
fi

echo
echo "Copy Docker Build: $IMAGE_TAG ..."

cd ${PROJECT_DIR}

# Use latest "git tag" to create a version or HEAD.
if [ -z "$TAG" ]; then
    GIT_TAG="HEAD"
else
    GIT_TAG=${TAG}
fi

# Create Git archive and transfer:
git archive --prefix=${PROJECT_NAME}/ -o git-${PROJECT_NAME}.tar ${GIT_TAG}
# Add version.txt file and compress...
tar -rf git-${PROJECT_NAME}.tar ../${PROJECT_NAME}/deployment/version.txt
gzip git-${PROJECT_NAME}.tar
scp git-${PROJECT_NAME}.tar.gz ${BUILD_HOST}:${BUILD_DIR}

# Unpack source TAR and build docker image:
SSH_CMD="/bin/bash -c \"cd ${BUILD_DIR} && tar -xzf git-${PROJECT_NAME}.tar.gz && cd ./${PROJECT_NAME} && ./deployment/build.sh\""
echo SSH_CMD ${SSH_CMD}
ssh ${BUILD_HOST} ${SSH_CMD}
RETCODE=$?

cd -

echo "Build Finished: $IMAGE_TAG"
echo
exit $RETCODE
