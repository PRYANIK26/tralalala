FROM alpine:3.22 AS tools
RUN apk add --no-cache ffmpeg python3 py3-pip && \
    pip3 install --break-system-packages yt-dlp

FROM docker.n8n.io/n8nio/n8n:2.19.5
USER root

# Бинарники
COPY --from=tools /usr/bin/ffmpeg /usr/bin/
COPY --from=tools /usr/bin/ffprobe /usr/bin/
COPY --from=tools /usr/bin/python3 /usr/bin/
COPY --from=tools /usr/bin/yt-dlp /usr/bin/

# Библиотеки (из /usr/lib и /lib — на Alpine OpenSSL живёт в /lib)
COPY --from=tools /usr/lib/ /usr/lib/
COPY --from=tools /lib/ /lib/

# Python share-data (stdlib и пакеты)
COPY --from=tools /usr/share/ /usr/share/

USER node
