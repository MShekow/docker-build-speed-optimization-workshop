# docker-build-speed-optimization-workshop
A small workshop that applies various optimization techniques to an example HTTP server implemented in Go

## Preparation

- Start Docker (Desktop)
- ```shell
  docker compose up -d registry
  ```
  - This creates the Docker network `docker-build-speed-optimization-workshop_default` and starts a local image registry server
- ```shell
  docker buildx create --driver docker-container --name mybuilder --use --bootstrap --config buildkit.toml --driver-opt "network=docker-build-speed-optimization-workshop_default"
  ```
  - This creates your personal, container-based builder that can push to the local registry



## Building and testing the image

- ```shell
  docker buildx build --platform linux/amd64,linux/arm64 -t registry:5000/go-server:latest --push .
  ```
  - This builds the multi-platform image and pushes it to the local registry
- ```shell
  docker compose up go-server
  ```
  - This starts the go-server in the container
  - Open http://localhost:8088 in the browser and verify that the server is running
  - `CTRL+C` to stop the go-server again
