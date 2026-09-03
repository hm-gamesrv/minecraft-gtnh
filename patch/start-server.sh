#!/bin/bash
set -euo pipefail

cd /app && exec java @user_jvm_args.txt -Dfml.readTimeout=180 @java9args.txt -jar lwjgl3ify-forgePatches.jar nogui "$@"