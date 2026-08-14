# =================
# 资源下载
# =================
FROM alpine:3 AS builder

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.8.4_Server_Java_17-25.zip
RUN unzip ./GT_New_Horizons_2.8.4_Server_Java_17-25.zip -d gtnh

# ===================
# 主镜像
# ===================
FROM eclipse-temurin:25-jre

ENV TZ=Asia/Shanghai

RUN mkdir -p /app && chown 1000:1000 /app

COPY --from=builder --chown=1000:1000 ["/downloads/gtnh", "/app"]
COPY --chown=1000:1000 ["./patch/", "/app"]

EXPOSE 25565/tcp 25575/tcp

VOLUME [ "/app/World", "/app/backups" ]

WORKDIR /app
USER 1000:1000
CMD ["bash", "/app/start-server.sh"]