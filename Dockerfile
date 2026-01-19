FROM docker.n8n.io/n8nio/n8n:1.121.3

USER root

# Установка всех зависимостей одной командой
RUN apk add --no-cache \
    ffmpeg \
    python3 \
    py3-pip && \
    pip3 install --break-system-packages yt-dlp && \
    chown -R node:node /home/node/.n8n

USER node
