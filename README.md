## Домашнее задание Сценарии iptables

### Описание домашнего задания
```
- knocking port реализован на inet-router
  central-server может попасть по ssh на inert-router через knock скрипт
- nginx установлен на central-server
- проброс на 80й порт central-server через порт 8080 на inet-router2
- central-server: дефолт в инет через inet-router

- VMs разворачиваются в среде VMware vSphere 7
- VMs разворачиваются из шаблона Centos 8 Stream
  
Файлы:

- network_scheme.pdf:         схема сети
- network.yml:                ansible playbook развертывания и настройки VMs
- vars.yml:                   переменные для создания и натройки VMs в VMware vSphere 7
- host:                       inventory

сценарий развeртывания VMs, include_tasks в network.yml
- router.yml:                 VMs inet-router, inet-router2 
- central-server.yml:         VM central-server
                              IP адрес VM недоступен с хоста ansible
                              использовались возможности модулей community.vmware.vmware...
                              после настройки iptables, policy routing, управление сервером
                              через проброс порта ssh на inet-router2

- iptables.sh:                скрипт задания правил iptables inet-router
                              настроен NAT
                              настроен knocking port ssh на внутреннем интерфейсе

- iptables2.sh:               скрипт задания правил iptables inet-router2
                              настроен NAT
                              настроен проброс портов:
                              10.100.11.122:8080 -> 192.168.50.30:80
                              10.100.11.122:2022 -> 192.168.50.30:20
							  
- iptables3.sh:               скрипт задания правил iptables cental-server
                              настроен policy routing
                              все пакеты с портов: 80, 22 отправляются через inet-router2 (192.168.50.20)
                              default gateway 192.168.50.10
							  
- scan-ports.sh:              скрипт central-server для открытия порта ssh на внутреннем интерфейсе inet-router

 Результаты проверки в скриншотах:
- scans\ansible.jpg:          работа ansible-playbook
- scans\cental-server.jpg:    настройка iptables, policy routing, доступ в инет
- scans\nginx.jpg:            доступ к nginx на cental-server через inet-router2
- scans\knocking.jpg:         доступ с central-server по ssh на inet-router (внутренний интерфейс)

 
