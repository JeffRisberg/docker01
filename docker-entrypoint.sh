#!/bin/sh
set -ex

if [ -z "${LOGSTASH_TCP_DESTINATION}" ]; then
    export HOST_MACHINE=$(curl --connect-timeout 2 -s 169.254.169.254/latest/meta-data/local-ipv4 || echo localhost)
    export LOGSTASH_TCP_DESTINATION=$HOST_MACHINE:4560
fi

if [ -z "${SLACK_URL}" ]; then
    case "${ENVIRONMENT}" in
        production )
        conf_version=$(aws s3 cp s3://iv-tmp/ops/config/version-production.txt -)
        ;;
        staging )
        conf_version=$(aws s3 cp s3://iv-tmp/ops/config/version-staging.txt -)
        ;;
        * )
        conf_version=$(aws s3 cp s3://iv-tmp/ops/config/version-development.txt -)
        ;;
    esac
    aws s3 cp "s3://iv-tmp/ops/config/${conf_version}/quanticmind/${APPLICATION}/service/environment-config" /etc/quanticmind/environment-config
    . /etc/quanticmind/environment-config
fi

exec "$@"
