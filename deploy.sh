#!/usr/bin/env bash

set -x

if [[ $# != 2 ]]; then
  echo -e "\n\tUsage: $0 [ENVIRONMENT] <plan|apply|destroy>\n\n\tExample: $0 dev apply\n"
  exit 1
fi

export environment="${1}"
subcommand="${2}"

export application_name="docker01"

if [[ $environment == 'dev' ]]; then

    if [ "${subcommand}" == "apply" ]; then
        # Make sure that docker-machine is running and connected.
        docker-machine start default
        eval $(docker-machine env default)
        eval $(aws ecr get-login --profile MainAWS --registry-ids 853301516381 --no-include-email)

        export APP_VERSION=$(cd target/classes; cat 'version.properties' | grep "timestamp" | cut -d'=' -f2)

        docker-compose -f docker-compose.yml -f dev.yml up -d
    fi # End if

    if [ "${subcommand}" == "destroy" ]; then
        docker-compose -f docker-compose.yml -f dev.yml down
    fi

else
    # Sets up ecs-cli to communicate with this cluster
    ecs-cli configure --region "us-east-1" -cluster $ECS_CLUSTER --compose-service-name-prefix "" --compose-project-name-prefix "" || { echo "Error configuring ecs-cli"; exit; }

    # Get APP_VERSION from deploy descriptor
    export APP_VERSION=$(curl -s https://artifacts.internal.quanticmind.com/${environment}/deploy_descriptor.json | jq -r ".artifacts.${artifact_name}.version") || { echo "unable to get version from build descriptor"; exit; }

fi # End else
