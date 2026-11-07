# =================
# 资源下载
# =================
FROM alpine:3 AS download

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads

# GTNH 服务端包文件名；升级版本时只改这里
ARG SERVER_PACK=GT_New_Horizons_2.9.0_Server_Java_17-26.zip

RUN wget -q "https://downloads.gtnewhorizons.com/ServerPacks/${SERVER_PACK}" \
    && unzip "./${SERVER_PACK}" -d gtnh \
    && rm -f "./${SERVER_PACK}"

# ===================
# 主镜像
# ===================
FROM eclipse-temurin:26-jre

ENV TZ=Asia/Shanghai

RUN mkdir -p /app && chown 1000:1000 /app

COPY --from=download --chown=1000:1000 ["/downloads/gtnh", "/app"]
COPY --chown=1000:1000 ["./init.sh", "/usr/local/bin/init.sh"]
COPY --chown=1000:1000 ["./patch/", "/app"]

EXPOSE 25565/tcp 25575/tcp

VOLUME [ "/app/World", "/app/backups" ]

WORKDIR /app
USER 1000:1000
ENTRYPOINT [ "sh", "/usr/local/bin/init.sh" ]
CMD ["bash", "/app/start-server.sh"]
