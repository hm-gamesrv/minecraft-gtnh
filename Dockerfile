# =================
# 资源下载
# =================
FROM alpine:latest AS builder

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.8.4_Server_Java_17-25.zip
RUN unzip ./GT_New_Horizons_2.8.4_Server_Java_17-25.zip -d gtnh

# ===================
# 基座镜像
# ===================
FROM eclipse-temurin:25-jre

EXPOSE 25565/tcp 25575/tcp

VOLUME [ "/app/World", "/app/backups" ]

ENV TZ=Asia/Shanghai

RUN mkdir -p /app && chown 1000:1000 /app
USER 1000:1000

COPY --from=builder --chown=1000:1000 ["/downloads/gtnh", "/app"]
COPY --chown=1000:1000 ["./patch/", "/app"]

WORKDIR /app

CMD ["bash", "/app/start-server.sh"]