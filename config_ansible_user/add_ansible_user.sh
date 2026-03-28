#!/bin/bash

# 1. Создаём пользователя ansible с домашним каталогом и оболочкой bash
useradd -m -s /bin/bash ansible

# 2. Добавляем пользователя в группу wheel (обычно имеет права sudo)
usermod -aG wheel ansible

# 3. Отключаем запрос пароля для sudo
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
chmod 440 /etc/sudoers.d/ansible

# 4. (Опционально) Разрешаем аутентификацию по SSH-ключам и добавляем публичный ключ
#    Если у вас уже есть ключ Ansible-контроллера, скопируйте его на сервер и выполните:
# mkdir -p /home/ansible/.ssh
# cat /config_ansible_user/ansible.pub >> /home/ansible/.ssh/authorized_keys
# chown -R ansible:ansible /home/ansible/.ssh
# chmod 700 /home/ansible/.ssh
# chmod 600 /home/ansible/.ssh/authorized_keys

# Проверка: от имени ansible можно выполнить любую команду без пароля
# su - ansible -c "sudo -l"