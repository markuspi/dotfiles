#!/bin/bash
set -e

VERSION=${VERSION:-1.16.4}
INSTALL_DIR="${HOME}/minecraft-server"

mkdir -p "${INSTALL_DIR}"
cd "${INSTALL_DIR}"

wget "https://papermc.io/api/v1/paper/${VERSION}/latest/download" -O papermc.jar

echo "eula=true" > eula.txt

cat << EOF > server.properties
level-seed=${SEED}
online-mode=${ONLINE}
op-permission-level=1
EOF

cat << EOF > run.sh
java -jar papermc.jar
EOF
chmod +x run.sh

tmux new -s mc -n server -d
tmux send-keys -s mc "${INSTALL_DIR}/run.sh" ENTER
