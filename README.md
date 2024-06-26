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

## Tutorial

Apply the following steps to improve the build speed (**note**: the solution can be found in the `tutorial` branch):
- Use a smart `RUN` statement order to speed up installing the Go modules
- Add a `.dockerignore` file to exclude unnecessary files from the build context
- Add BuildKit cache mounts to speed up the downloading of dependencies ([module cache](https://go.dev/ref/mod#module-cache)) and building the binary ([build cache](https://pkg.go.dev/cmd/go#hdr-Build_and_test_caching))
- Make use of a multi-stage build and use _cross-compilation_ to speed up building the binary for multiple platforms
