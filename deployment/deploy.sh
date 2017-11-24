#! /bin/bash
#
# Deploy Docker Image(s) using docker-compose
# =============================================================================
# Download & deploy one or more images using a docker-compose.yml definition.
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

$SUDO docker login -u ${REG_MECHID}@${NAMESPACE} -p ${REG_PASSWD} -e ${REG_MECHID}@att.com ${REGISTRY}

$SUDO docker-compose -f docker-compose-${TIER}.yml pull web
$SUDO docker-compose -f docker-compose-${TIER}.yml down
$SUDO docker-compose -f docker-compose-${TIER}.yml up -d

$SUDO docker logout ${REGISTRY}

if [ "$SUDO" ]; then
    ./deployment/cleanup_docker.sh
else
    ./deployment/cleanup_docker.sh -S
fi

cd -

echo "Deployed: $IMAGE_TAG"
echo
