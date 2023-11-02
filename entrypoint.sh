#!/bin/bash -e

export VNC_PASSWORD=${VNC_PASSWORD:-""}
export CHROME_PROXY_OPTS=${CHROME_PROXY_OPTS:-" -l 0.0.0.0:9222 -r 127.0.0.1:19222"}
export SCREEN_WIDTH=${SCREEN_WIDTH:-"1280"}
export SCREEN_HEIGHT=${SCREEN_HEIGHT:-"720"}
export SCREEN_SIZE=${SCREEN_SIZE:-"${SCREEN_WIDTH}x${SCREEN_HEIGHT}x24"}
export CHROME_OPTS=${CHROME_OPTS:-"\
  --no-sandbox \
  --no-first-run \
  --disable-dev-shm-usage \
  --remote-debugging-port=19222 \
  --window-position=0,0 \
  --window-size=${SCREEN_WIDTH},${SCREEN_HEIGHT} \
"}

if [ -n "${VNC_PASSWORD}" ]; then
  export VNC_AUTH="-passwd ${VNC_PASSWORD}"
else
  export VNC_AUTH="-nopw"
fi

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
