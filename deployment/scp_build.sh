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

# Create Git archive: Use HEAD
# TODO: Use "git tag" to create a version.
git archive --prefix=${PROJECT_NAME}/ -o git-${PROJECT_NAME}.tar.gz HEAD
scp git-${PROJECT_NAME}.tar.gz ${BUILD_HOST}:${BUILD_DIR}

SSH_CMD="/bin/bash -c \"cd ${BUILD_DIR} && tar -xzf git-${PROJECT_NAME}.tar.gz && cd ./${PROJECT_NAME} && ./deployment/build.sh\""
echo SSH_CMD ${SSH_CMD}
ssh ${BUILD_HOST} ${SSH_CMD}

cd -

echo "Build Finished: $IMAGE_TAG"
echo
