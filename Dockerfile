# 镜像选择 p4gefau1t/trojan-go
FROM p4gefau1t/trojan-go:latest

# 1. 安装 Caddy
WORKDIR /root/
RUN wget https://github.com/caddyserver/caddy/releases/download/v2.8.4/caddy_2.8.4_linux_amd64.tar.gz
RUN tar zxvf caddy_2.8.4_linux_amd64.tar.gz
RUN mv caddy /usr/local/bin/

# 2. 下载伪装页面
RUN mkdir -vp /var/www/html/
WORKDIR /var/www/html/
RUN wget https://github.com/YaninaTrekhleb/restaurant-website/archive/refs/heads/master.zip
RUN unzip master.zip
RUN mv /var/www/html/restaurant-website-master/* /var/www/html/

# 3. 编辑 Caddy 的配置文件
RUN mkdir -vp /etc/caddy/
RUN echo "localhost:80 {" > /etc/caddy/Caddyfile
RUN echo "  root * /var/www/html" >> /etc/caddy/Caddyfile
RUN echo "  file_server" >> /etc/caddy/Caddyfile
RUN echo "}" >> /etc/caddy/Caddyfile

# 4. 备份 Trojan-Go 的配置文件
RUN cp /etc/trojan-go/config.json /etc/trojan-go/config.json.bak

# 5. 使用新的 entrypoint.sh 启动脚本
# 拷贝 entrypoint.sh 到容器
COPY entrypoint.sh /root/entrypoint.sh
ENTRYPOINT ["/bin/sh", "/root/entrypoint.sh"]