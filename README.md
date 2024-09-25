# Trojan-Go-Docker

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