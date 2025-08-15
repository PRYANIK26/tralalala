FROM docker.n8n.io/n8nio/n8n:latest
USER root
RUN apk add --no-cache ffmpeg curl python3 py3-pip && \
    pip3 install --break-system-packages gdown
RUN npm install -g @aws-sdk/client-s3 axios jsonwebtoken
RUN chown -R node:node /home/node/.n8n
USER node
