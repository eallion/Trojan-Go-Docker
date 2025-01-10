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
  -e UMAMI_SRC="umami.example.com" \
  -e UMAMI_WEBSITE_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx" \
  -e TURNSTILE_SITEKEY="0x4AAAAAAAAAAAAAAAAAAAAA" \
  eallion/trojan-go:latest
```

## Fork：

- 修改默认网站
- 重新构建镜像

## 环境变量
可选：
- `UMAMI_SRC`
- `UMAMI_WEBSITE_ID`
- `TURNSTILE_SITEKEY`