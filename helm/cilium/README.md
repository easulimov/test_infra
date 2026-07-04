```bash
helm template cilium helm/cilium/charts/1.17.17 \
--namespace kube-system \
-f myvalues.yaml > .render/cilium-render.yaml
```

```bash
helm install cilium helm/cilium/charts/1.17.17 \
--namespace kube-system \
-f myvalues.yaml
```