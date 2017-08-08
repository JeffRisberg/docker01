#!/bin/bash

set -e

if [[ $# != 1 ]]; then
  echo -e "\n\tUsage: $0 [ENVIRONMENT]\n\n\tExample: $0 dev\n"
  exit 1
fi

environment=$1

case "$environment" in
    dev )
        mvn clean compile resources:resources assembly:single;;
    jenkins )
        mvn clean compile resources:resources assembly:single;;
    * )
        echo "Invalid argument: Must be 'dev' or 'jenkins'"; exit ;;
esac

APP_VERSION=$(cd target/classes; cat 'version.properties' | grep "timestamp" | cut -d'=' -f2)

./docker-publish.sh $environment $APP_VERSION
