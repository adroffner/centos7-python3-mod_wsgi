#! /bin/bash
#
# Docker Image: CentOS 7 - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Build docker image
# =============================================================================

# IBM-3270 support when non-empty string.
IBM_3270=""

REGISTRY="dockercentral.it.att.com:5100"
NAMESPACE="com.att.dev.argos"
IMAGE_NAME="centos7-python3-mod_wsgi"
TAG="3.6.6"

if [ -n "${IBM_3270}" ]; then
	echo "IBM 3270 support"
	IMAGE_NAME="${IMAGE_NAME}-ibm3270"
	DOCKERFILE=Dockerfile.ibm-3270
else
	# Just build main project.
	DOCKERFILE=Dockerfile
fi


FULL_IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

docker login -u m12292@argos.dev.att.com -p 3W2-CDP-naF-3aN -e m12292@att.com ${REGISTRY}

docker build -t $FULL_IMAGE_NAME ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    -f ${DOCKERFILE}
