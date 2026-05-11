FROM alpine:3.20 AS tools
RUN apk add --no-cache ffmpeg python3 py3-pip && \
    pip3 install --break-system-packages yt-dlp

FROM docker.n8n.io/n8nio/n8n:2.19.5
USER root
COPY --from=tools /usr/bin/ffmpeg /usr/bin/ffprobe /usr/bin/python3 /usr/bin/yt-dlp /usr/bin/
COPY --from=tools /usr/lib/ /usr/lib/
COPY --from=tools /usr/share/ /usr/share/
USER node
