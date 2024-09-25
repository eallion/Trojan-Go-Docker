#!/bin/sh

# 1. 判断 Trojan-Go 配置是否存在
# 1.1 配置文件 /etc/trojan-go/config.json
rm -rf /etc/trojan-go/config.json
cp /root/config.json.bak /etc/trojan-go/config.json
if [ ! -f /etc/trojan-go/config.json ]; then
    echo "Trojan-Go config file /etc/trojan-go/config.json is required!"
    exit 1
fi
# 1.2 SSL 证书
if [ ! -f /etc/trojan-go/certificate.crt ]; then
    echo "Trojan-Go ssl certificate /etc/trojan-go/certificate.crt is required!"
    exit 1
fi
chmod 755 /etc/trojan-go/certificate.crt
if [ ! -f /etc/trojan-go/private.key ]; then
    echo "Trojan-Go ssl private key /etc/trojan-go/private.key is required!"
    exit 1
fi
chmod 755 /etc/trojan-go/private.key
# 1.3 Trojan-Go 服务密码
if [ ! -n "$TROJAN_GO_SERVICE_PASSWORD" ]; then
    echo "ENV TROJAN_GO_SERVICE_PASSWORD is required!"
    exit 1
fi
# 1.4 Trojan-Go 服务域名
if [ ! -n "$TROJAN_GO_SERVICE_DOMAIN" ]; then
    echo "ENV TROJAN_GO_SERVICE_DOMAIN is required!"
    exit 1
fi

# 2. 判断 Caddy 配置是否存在
if [ ! -f /etc/caddy/Caddyfile ]; then
    echo "Caddy config file /etc/caddy/Caddyfile is required!"
    exit 1
fi

# 3. 启动 Caddy
caddy start --config /etc/caddy/Caddyfile

# 4. 替换 Trojan-Go 配置文件内容
# 替换域名和密码
sed -i "s/your_password/$TROJAN_GO_SERVICE_PASSWORD/" /etc/trojan-go/config.json
sed -i "s/your-domain-name.com/$TROJAN_GO_SERVICE_PASSWORD/" /etc/trojan-go/config.json
# 将 your_cert.crt 替换为 /etc/trojan-go/certificate.crt
sed -i "s/your_cert.crt/\/etc\/trojan-go\/certificate.crt/" /etc/trojan-go/config.json
# 将 your_private.key 替换为 /etc/trojan-go/private.key
sed -i "s/your_private.key/\/etc\/trojan-go\/private.key/" /etc/trojan-go/config.json

# 5. 启动 Trojan-Go
/usr/local/bin/trojan-go -config /etc/trojan-go/config.json