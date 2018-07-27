#! /bin/bash
#
# =============================================================================
# Delete previous local containers and images to save disc space.
# =============================================================================

source ./deployment/configs.env

SUDO="sudo" # default

# =============================================================================

# Execute getopt
ARGS=`getopt -o "S" -l "no-sudo" -n "getopt.sh" -- "$@"`

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
        --)
            shift 1
            break
        ;;
    esac
done

# =============================================================================

echo
echo "Deleting earlier Docker containers and images for $IMAGE_TAG ..."

# Containers first (they depend on images)
EXITED_IDS=$($SUDO docker ps -a -f status=exited | grep ${IMAGE_TAG%:*} | awk '{print $1}')
if [ -n "${EXITED_IDS}" ]; then
    $SUDO docker rm $EXITED_IDS
fi

# Match all related images except the current TAG, plus <none> (dangling=true):
IMAGE_OLD_IDS=$($SUDO docker images | grep ${IMAGE_TAG%:*} | grep -v ${IMAGE_TAG##*:} | awk '{print $3}')
IMAGE_DANGLING_IDS=$($SUDO docker images -q -f "dangling=true")
if [ -n "${IMAGE_OLD_IDS}" ] || [ -n "${IMAGE_DANGLING_IDS}" ]; then
    $SUDO docker rmi $IMAGE_OLD_IDS $IMAGE_DANGLING_IDS
fi

echo "Cleaned Up: $IMAGE_TAG"
echo
