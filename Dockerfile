# 选择一个小巧的 Nginx 镜像
FROM nginx:alpine

# 删除默认 nginx 静态资源
RUN rm -rf /usr/share/nginx/html/*

# 拷贝打包后的文件到 nginx 静态目录
COPY dist/ /usr/share/nginx/html/

# 拷贝自定义 nginx 配置（可选）
# COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 5173

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]