### 1. СОЗДАНИЕ ДИРЕКТОРИИ ДЛЯ БЕКАПОВ
```bash
mkdir -p /root/k8s-proxy-backup
```

### 2. БЕКАП CONFIGMAP И DAEMONSET KUBE-PROXY
```bash
kubectl get cm kube-proxy -n kube-system -o yaml > /root/k8s-proxy-backup/kube-proxy-cm.yaml
kubectl get ds kube-proxy -n kube-system -o yaml > /root/k8s-proxy-backup/kube-proxy-ds.yaml
```

### 3. БЕКАП CONFIGMAP KUBEADM-CONFIG
```bash
kubectl get cm kubeadm-config -n kube-system -o yaml > /root/k8s-proxy-backup/kubeadm-config-cm.yaml
```

### 4. РЕДАКТИРОВАНИЕ KUBEADM-CONFIG (ДОБАВЛЕНИЕ proxy.disabled: true)
#### Команда автоматически находит блок 'ClusterConfiguration' и внедряет туда параметр 'proxy.disabled: true' (валидно для K8s v1.33+)
```bash
kubectl get cm kubeadm-config -n kube-system -o yaml | sed '/kind: ClusterConfiguration/a \ \ proxy:\n\ \ \ \ disabled: true' | kubectl apply -f -
```

### 5. УДАЛЕНИЕ CILIUM (ОЧИСТКА ВСЕХ РЕСУРСОВ ИЗ МАНИФЕСТОВ И CRD)
#### Так как Cilium ставился из манифестов, удаляем все ресурсы по его стандартным системным меткам
```bash
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/part-of=cilium --ignore-not-found
kubectl delete configmap,secret,serviceaccount -n kube-system -l app.kubernetes.io/part-of=cilium --ignore-not-found
kubectl delete deployment,daemonset -n kube-system -l app.kubernetes.io/part-of=cilium --ignore-not-found
kubectl delete service,endpoints -n kube-system -l app.kubernetes.io/part-of=cilium --ignore-not-found
```

#### Удаление кастомных ресурсов (CRD) Cilium, чтобы очистить остатки в API-сервере
```bash
kubectl delete crd -l app.kubernetes.io/part-of=cilium --ignore-not-found
```

### 6. УДАЛЕНИЕ CONFIGMAP И DAEMONSET KUBE-PROXY ИЗ СИСТЕМЫ
```bash
kubectl delete ds kube-proxy -n kube-system --ignore-not-found
kubectl delete cm kube-proxy -n kube-system --ignore-not-found
```

### 7. ЗАЧИСТКА ПРАВИЛ IPTABLES, СВЯЗАННЫХ С KUBE-PROXY
#### (Выполняется на каждом узле кластера, где работал kube-proxy. На AlmaLinux 9 используется синтаксис iptables-save/restore)
```bash
iptables-save | grep -v KUBE- | iptables-restore
```