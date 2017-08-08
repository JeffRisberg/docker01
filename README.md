# Reporting Status Service

### To run this project against a test channel

Use the command,

`PORT=yourPort# SLACK_URL=slackWebhookUrl java -jar reporting-status-service-version.jar`


For example,

`PORT=8000 SLACK_URL=https://hooks.slack.com/services/T02e3310E6/B635634 java -jar build/libs/reporting-status-service-fd2dgdge3.jar`


You can get a webhook url for testing from ops

# Development

* Redis back store uses '|' as a delimiter between message and date.
    Don't use '|' in messages.
