#!/bin/bash
set -euo pipefail

cd /app

for f in user_jvm_args.txt java9args.txt lwjgl3ify-forgePatches.jar; do
    [ -f "$f" ] || { echo "[start-server] missing /app/$f" >&2; exit 1; }
done

exec java @user_jvm_args.txt @java9args.txt -jar lwjgl3ify-forgePatches.jar nogui "$@"