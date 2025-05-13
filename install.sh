#!/bin/bash

set -e

echo "🚀 开始安装 TeslaMate..."

# 更新系统包
sudo apt update && sudo apt upgrade -y

# 安装 Docker
if ! command -v docker &> /dev/null
then
    echo "🔧 正在安装 Docker..."
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
fi

# 安装 Docker Compose
if ! command -v docker-compose &> /dev/null
then
    echo "🔧 正在安装 Docker Compose..."
    sudo apt install -y docker-compose
fi

# 创建 teslamate 目录
mkdir -p ~/teslamate
cd ~/teslamate

# 克隆 TeslaMate 仓库
if [ ! -d "teslamate" ]; then
    git clone https://github.com/adriankumpf/teslamate.git
    cd teslamate
    cp docker-compose.yml.dist docker-compose.yml
else
    echo "📁 teslamate 已存在，跳过克隆。"
    cd teslamate
fi

# 启动 TeslaMate
echo "🚀 正在启动 TeslaMate..."
docker-compose up -d

echo "✅ 安装完成！请在浏览器中访问 http://localhost 查看 TeslaMate。"
