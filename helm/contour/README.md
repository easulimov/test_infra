Рендеринг чарта
```bash
helm template contour helm/contour/charts/1.33.5 \
--namespace contour-system --create-namespace \
-f helm/contour/values/myvalues.yaml > .render/contour-render.yaml
```

Установка чарта
```bash
helm upgrade --install contour helm/contour/charts/1.33.5 \
--namespace contour-system --create-namespace \
-f helm/contour/values/myvalues.yaml
```
