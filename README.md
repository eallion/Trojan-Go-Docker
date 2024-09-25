# Trojan-Go-Docker

## 简介
参考博文：[Trojan-Go 服务 Docker 镜像制作](https://senjianlu.com/2024/09/25/docker_trojan/)

## 启动
```bash
docker run -d \
  --name trojan-go \
  --restart=unless-stopped \
  -p 8443:443 \
  -v /rab/docker/trojan-go/:/etc/trojan-go/ \
  -e TROJAN_GO_SERVICE_PASSWORD="yourPassword" \
  -e TROJAN_GO_SERVICE_DOMAIN="trojan.example.com" \
  rabbir/trojan-go:latest
```