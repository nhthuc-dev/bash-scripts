#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color
export DEBIAN_FRONTEND=noninteractive

echo -e "${GREEN}🔹 Cập nhật hệ thống...${NC}"
apt update -y && apt upgrade -y

# ------------------- Cài đặt Docker -------------------
echo -e "${GREEN}🔹 Cài đặt Docker ...${NC}"
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io
systemctl enable --now docker

# Cài đặt Docker Compose
echo -e "${GREEN}🔹Docker Compose...${NC}"
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | cut -d '"' -f 4)
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo -e "${GREEN}🔹Docker Compose Done${NC}"
# ------------------- END Cài đặt Docker -------------------
