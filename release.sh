#!/bin/bash -ux
json=$(curl -sf https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json)

CHROME_VERSION=$(echo "$json" | jq .channels.Stable.version -r)
CHROME_URL=$(echo "$json" | jq '.channels.Stable.downloads.chrome[] | select(.platform == "linux64").url' -r)

DOCKER_URL="ghcr.io/hrntknr/google-chrome-remote:$CHROME_VERSION"

if docker pull "$DOCKER_URL"; then
  echo "$DOCKER_URL already exists"
  exit 0
fi

docker build --build-arg CHROME_URL="$CHROME_URL" -t "$DOCKER_URL" .
docker push "$DOCKER_URL"
