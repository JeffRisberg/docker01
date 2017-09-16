# Docker01 example

## Development

This uses Ratpack to build a microservice.  Then creates a Docker image of that service with all
dependencies, then deploys it to Docker.

## Build

`./run-build dev`

This will build the image locally.

## Deploy to docker

`./deploy.sh dev apply`

## Sample run

`curl $(docker-machine ip default):8080`

`curl $(docker-machine ip default):8080/users`

## Connect a debugger to the running process in Docker

You don't need the Docker Integration plug in, but you do need to set up a "Remote debug" run
configuration that points to the IP address of the Docker container, and specifies the 50505
port, since this port has been set up as the debug port in the Cmd used in the Dockerfile.

