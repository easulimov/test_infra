Установка CRDs
```bash
helm install prometheus-operator-crds prometheus-community/prometheus-operator-crds \
  --namespace monitoring
```

Рендеринг чарта
```bash
helm template cilium helm/cilium/charts/1.17.17 \
--namespace kube-system \
-f helm/cilium/values/myvalues.yaml \
--set prometheus.serviceMonitor.trustCRDsExist=true > .render/cilium-render.yaml
```

Установка чарта
```bash
helm install cilium helm/cilium/charts/1.17.17 \
--namespace kube-system \
-f helm/cilium/values/myvalues.yaml
```
