Рендер манифестов
```bash
helm template cert-manager helm/cert-manager/charts/1.20.3 \
  --namespace cert-manager \
  --set crds.enabled=true > .render/cert-manager.yaml
```

Установка чарта
```bash
helm install cert-manager helm/cert-manager/charts/1.20.3 \
  --namespace cert-manager \
  --set crds.enabled=true
```

Апгрейд чарта с поддержкой GatewayAPI (после установки CRD GatewayAPI)
```bash
helm upgrade --install cert-manager helm/cert-manager/charts/1.20.3 \
  --namespace cert-manager \
  --set crds.enabled=true \
  --set config.enableGatewayAPI=true
```