FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y ca-certificates curl wget gnupg2 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

ARG PROXY_VERSION=0.5.8
RUN wget -q https://github.com/wendigo/chrome-protocol-proxy/releases/download/v${PROXY_VERSION}/chrome-protocol-proxy_${PROXY_VERSION}_linux_x86_64.tar.gz -O /tmp/chrome-protocol-proxy.tar.gz && \
  tar -xzf /tmp/chrome-protocol-proxy.tar.gz -C /usr/local/ && \
  ln -s /usr/local/chrome-protocol-proxy_${PROXY_VERSION}_linux_x86_64/chrome-protocol-proxy /usr/local/bin/chrome-protocol-proxy && \
  rm /tmp/chrome-protocol-proxy.tar.gz

ARG CHROME_RELEASE_VERSION
RUN apt-get update && \
  apt-get install -y supervisor x11vnc novnc python3-websockify xvfb pulseaudio fonts-noto-cjk unzip google-chrome-stable=$CHROME_RELEASE_VERSION-1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./entrypoint.sh /entrypoint.sh

ARG USER=chrome
RUN useradd -m ${USER}
USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT ["/entrypoint.sh"]
