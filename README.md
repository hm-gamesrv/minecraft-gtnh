# Minecraft GTNH Server

## 1. 简述

MC 格雷科技整合包服务器

**可用版本：**

| 游戏模式   | 镜像 tag |
| ---------- | -------- |
| 最新正式版 | `latest` |

## 2. 资源占用信息

### 2.1. 端口

| 端口号 | 协议 | 说明         |
| ------ | ---- | ------------ |
| 25565  | TCP  | 游戏联机端口 |
| 25575  | TCP  | RCON 端口    |

### 2.2. 持久卷

| 容器路径       | 说明                         |
| -------------- | ---------------------------- |
| `/app/World`   | 游戏世界存档                 |
| `/app/backups` | ServerUtilities 模组备份路径 |

## 3. 构建与运行

### 3.1. 构建并运行（Docker）

```bash
docker build -t minecraft-gtnh:temp . && \
    docker run --rm -it \
        -p 25565:25565/tcp \
        -p 25575:25575/tcp \
        -v ./World:/app/World \
        -v ./backups:/app/backups \
        minecraft-gtnh:temp
```

### 3.2. 运行服务器（Podman）

```bash
IMAGE=ghcr.io/hm-gamesrv/minecraft-gtnh:latest

if ! podman pull "$IMAGE"; then
    exit 1
fi

podman run --rm -it \
    --name minecraft-gtnh \
    --userns keep-id \
    --network pasta \
    -p 25565:25565/tcp \
    -p 25575:25575/tcp \
    -v ./World:/app/World \
    -v ./backups:/app/backups \
    "$IMAGE"
```
