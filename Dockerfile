FROM alpine:latest

# 安装必要的包
RUN apk add --no-cache ca-certificates curl unzip

# 下载并安装V2Ray
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && unzip /tmp/v2ray.zip -d /usr/local/bin/ \
    && rm /tmp/v2ray.zip \
    && chmod +x /usr/local/bin/v2ray

# 复制配置文件
COPY config.json /etc/v2ray/config.json

# 暴露端口（Render会自动分配）
EXPOSE 10000

# 启动V2Ray
CMD ["/usr/local/bin/v2ray", "run", "-c", "/etc/v2ray/config.json"]
