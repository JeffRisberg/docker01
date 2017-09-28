#!/bin/bash

set -e

if [[ $# != 2 ]]; then
  echo -e "\n\tUsage: $0 [BUILD_ENV] [VERSION]\n\n\tExample: $0 dev 5e7368fac9b6ad442eef8ff355110b04c458714f\n"
  exit 1
fi

BUILD_ENV=$1
APP_VERSION=$2
DOCKER_BASE_URL="853301516381.dkr.ecr.us-west-2.amazonaws.com/docker01"
FULL_ECR_PATH=$DOCKER_BASE_URL:$APP_VERSION

APPLICATION="docker01"
JAR="target/docker01-jar-with-dependencies.jar"

echo "Building Docker Image $FULL_ECR_PATH for $APPLICATION."
docker build -t $FULL_ECR_PATH . --build-arg APP_VERSION=$APP_VERSION --build-arg APP=$APPLICATION --build-arg JAR=$JAR

#if [ "${BUILD_ENV}" == "jenkins" ]; then
if [ true ]; then
    echo "Logging into AWS ECR Docker Repository."
    eval "$(aws ecr get-login --profile MainAWS --no-include-email)"

    echo "Pushing $FULL_ECR_PATH"
    docker push $FULL_ECR_PATH

    echo "Successful Image Build and Publish to ECR!"
else
    echo "Successful Image Build Locally!"
fi
