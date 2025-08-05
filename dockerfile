FROM node:20-alpine

WORKDIR /app

# 将我们新创建的启动脚本复制到容器中
COPY start-render.sh .
# 赋予该脚本可执行权限
RUN chmod +x start-render.sh

# 复制所有其他项目文件
COPY . .

# 安装 pnpm
RUN npm install -g pnpm

# 安装后端依赖
RUN pnpm install --frozen-lockfile

# 修复 rollup 可选依赖问题并安装前端依赖
RUN cd ui && npm install

# 构建整个项目（后端+前端）
RUN pnpm run build

# 暴露服务端口
EXPOSE 3456

# 容器的启动命令，改为执行我们的启动脚本
CMD ["/bin/sh", "./start-render.sh"]
