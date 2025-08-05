#!/bin/sh

# 遇到任何错误则立即退出
set -e

# 1. 打印日志，方便在 Render 后台查看
echo "==> [Render Start Script] Setting up config directory and symlink..."

# 2. 创建应用程序期望的配置目录
#    -p 选项确保如果目录已存在也不会报错
mkdir -p /root/.claude-code-router

# 3. 将 Render 放置的 Secret File 链接到应用程序期望的位置
ln -sf /etc/secrets/config.json /root/.claude-code-router/config.json

# 4. 打印日志，确认准备工作完成
echo "==> [Render Start Script] Setup complete. Starting application..."

# 5. 执行原始的启动命令来启动 Node.js 服务
#    'exec' 会用 node 进程替换当前的 shell 进程，这是容器启动服务的最佳实践
exec node dist/cli.js start
