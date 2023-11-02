# Google Chrome Remote

## Usage

docker run -it --rm --memory 512mb ghcr.io/hrntknr/google-chrome-remote:latest

## Environment

| Name              | Default value                                        | Description                        |
| ----------------- | ---------------------------------------------------- | ---------------------------------- |
| VNC_PASSWORD      |                                                      | Password for VNC connection        |
| SCREEN_WIDTH      | 1280                                                 | Set the screen width in pixels     |
| SCREEN_HEIGHT     | 720                                                  | Set the screen height in pixels    |
| SCREEN_DEPTH      | 24                                                   | Set the screen color depth in bits |
| CHROME_PROXY_OPTS | -l 0.0.0.0:9222 -r 127.0.0.1:19222                   | Proxy options for Chrome           |
| CHROME_OPTS       | [Read entrypoint.sh](./chrome-release/entrypoint.sh) | Startup options for Chrome         |

## Expose ports

| Port | Description                                          |
| ---- | ---------------------------------------------------- |
| 9222 | Debugging port for Chrome                            |
| 5900 | Port for VNC connection                              |
| 6080 | Port for noVNC (browser-based VNC client) connection |

## Tags

| Tag                       | Description                                                |
| ------------------------- | ---------------------------------------------------------- |
| latest, ${version}        | Release version of Google Chrome Remote (From apt release) |
| stable, stable-${version} | Stable version of Google Chrome Remote                     |
| beta, beta-${version}     | Beta version of Google Chrome Remote                       |
| dev, dev-${version}       | Dev version of Google Chrome Remote                        |
| canary, canary-${version} | Canary version of Google Chrome Remote                     |
