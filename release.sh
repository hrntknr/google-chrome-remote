#!/bin/bash -eux
json=$(curl -sf https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json)

function build {
  tag=$1
  CHROME_VERSION=$(echo "$json" | jq ".channels.$tag.version" -r)
  CHROME_BIN_URL=$(echo "$json" | jq ".channels.$tag.downloads.chrome[] | select(.platform == \"linux64\").url" -r)

  DOCKER_URL="$REGISTRY/$IMAGE_NAME:${tag,,}-$CHROME_VERSION"

  if docker manifest inspect "$DOCKER_URL"; then
    echo "$DOCKER_URL already exists"
    continue
  fi

  docker build --build-arg CHROME_BIN_URL="$CHROME_BIN_URL" -t "$DOCKER_URL" chrome-for-testing
  docker push "$DOCKER_URL"
  docker tag "$DOCKER_URL" "$REGISTRY/$IMAGE_NAME:${tag,,}"
  docker push "$REGISTRY/$IMAGE_NAME:${tag,,}"
}

function build_release {
  tag=Stable
  CHROME_VERSION=$(echo "$json" | jq ".channels.$tag.version" -r)

  DOCKER_URL="$REGISTRY/$IMAGE_NAME:$CHROME_VERSION"

  if docker manifest inspect "$DOCKER_URL"; then
    echo "$DOCKER_URL already exists"
    continue
  fi

  docker build --build-arg CHROME_RELEASE_VERSION="$CHROME_VERSION" -t "$DOCKER_URL" chrome-release
  docker push "$DOCKER_URL"
  docker tag "$DOCKER_URL" "$REGISTRY/$IMAGE_NAME:latest"
  docker push "$REGISTRY/$IMAGE_NAME:latest"
}

build_release
tags=("Stable" "Beta" "Dev" "Canary")
for tag in "${tags[@]}"; do
  build "$tag"
done
