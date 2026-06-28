k8s_upgrade example:

```bash
ansible-playbook -i hosts/k8s.yaml upgrade-cluster.yml \
  -e "k8s_ver=1.33.13 crio_ver=1.33.13"
```

```bash
ansible-playbook -i hosts/k8s.yaml upgrade-cluster.yml \
  -e "k8s_ver=1.34.9 crio_ver=1.34.9"
```