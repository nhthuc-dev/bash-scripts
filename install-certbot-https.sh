#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color
export DEBIAN_FRONTEND=noninteractive

if [ "$(id -u)" != "0" ]; then
    echo -e "${YELLOW}This script requires root access.${NC}"
    echo -e "${YELLOW}Please enter root mode using 'sudo -i', then rerun this script.${NC}"
    exit 1
fi

# Kiểm tra tham số domain
if [ -z "$1" ]; then
    echo -e "${YELLOW}Please provide the domain as an argument. Usage: $0 <domain>${NC}"
    exit 1
fi

DOMAIN="$1"
EMAIL="admin@$DOMAIN"
SSL_PATH="/etc/letsencrypt/live/$DOMAIN"

echo -e "${GREEN}🔹 Cập nhật hệ thống...${NC}"
apt update -y && apt upgrade -y

# ------------------- Cài đặt SSL -------------------
# Cài đặt Certbot nếu chưa có
if ! command -v certbot &> /dev/null
then
    echo -e "${GREEN}🔹 Install Certbot...${NC}"
    apt install -y certbot
fi

if [ ! -f "$SSL_PATH/fullchain.pem" ]; then
    echo -e "${GREEN}🔹 Getting SSL for $DOMAIN...${NC}"
    certbot certonly --standalone --non-interactive --agree-tos --email $EMAIL -d $DOMAIN -d www.$DOMAIN
else
    echo -e "${GREEN}✅ Chứng chỉ SSL đã tồn tại, bỏ qua bước cấp mới.${NC}"
fi

if [ -f "$SSL_PATH/fullchain.pem" ]; then
    echo -e "${GREEN}✅ Chứng chỉ SSL đã được cấp thành công!${NC}"
else
    echo -e "${YELLOW}❌ Lỗi cấp chứng chỉ, kiểm tra lại domain!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Chứng chỉ SSL được lưu tại: $SSL_PATH${NC}"
# ------------------- END Cài đặt SSL -------------------
