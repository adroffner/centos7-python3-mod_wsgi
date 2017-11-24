#! /bin/bash
#
# =============================================================================
# Build docker image
# =============================================================================

source ./deployment/configs.env

SUDO="sudo" # default
PUSH_FLAG="true" # default

# =============================================================================

# Execute getopt
ARGS=`getopt -o "SP" -l "no-sudo,no-push" -n "getopt.sh" -- "$@"`

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
        --)
            shift 1
            break
        ;;
    esac
done

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

$SUDO docker logout ${REGISTRY}

if [ "$SUDO" ]; then
    ./deployment/cleanup_docker.sh
else
    ./deployment/cleanup_docker.sh -S
fi

echo "DONE: $IMAGE_TAG"
echo
