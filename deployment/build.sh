#! /bin/bash
#
# =============================================================================
# Build docker image
# =============================================================================

source ./deployment/configs.env

SUDO="sudo" # default
PUSH_FLAG="true" # default
LATEST_FLAG="" # default

# =============================================================================

# Execute getopt
ARGS=`getopt -o "SPL" -l "no-sudo,no-push,latest" -n "getopt.sh" -- "$@"`

# Bad arguments
if [ $? -ne 0 ]; then
    exit 1
fi

# A little magic
eval set -- "$ARGS"

# Now go through all the options
while true; do
    case "$1" in
        -S|--no-sudo)
            SUDO=""
            shift 1
        ;;
        -P|--no-push)
            PUSH_FLAG=""
            shift 1
        ;;
        -L|--latest)
            LATEST_FLAG="true"
            shift 1
        ;;
        --)
            shift 1
            break
        ;;
    esac
done

# Cannot set the --latest tag unless the image is pushed.
if [ -z "$PUSH_FLAG" ] && [ "$LATEST_FLAG" ]; then
    echo "WARNING: $0 --no-push is set...will not create --latest tag unless the image is pushed."
    LATEST_FLAG=""
fi

# =============================================================================

echo
echo "Building Docker image: $IMAGE_TAG ..."

$SUDO docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

$SUDO docker build -t $IMAGE_TAG \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    ./

if [ "$PUSH_FLAG" ]; then
    $SUDO docker push $IMAGE_TAG
fi

# Create and push --latest.
if [ "$PUSH_FLAG" ] && [ "$LATEST_FLAG" ]; then
    LATEST_TAG="${IMAGE_TAG%:*}:latest"
    $SUDO docker tag  $IMAGE_TAG  $LATEST_TAG
    $SUDO docker push $LATEST_TAG
fi

$SUDO docker logout ${REGISTRY}

if [ "$SUDO" ]; then
    ./deployment/cleanup_docker.sh
else
    ./deployment/cleanup_docker.sh -S
fi

echo "DONE: $IMAGE_TAG"
echo
