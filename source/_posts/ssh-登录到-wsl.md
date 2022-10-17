---
title: ssh 登录到 wsl
date: 2022-10-18 01:18:05
tags:
- wsl
- ssh
categories:
- wsl
---

局域网内主机登录到其他主机的 wsl 

<!--more-->

## wsl 到 windows 的端口映射

在 wsl 中通过 ifconfig 查看 ip，一定要使用该 ip，不要使用 windows 网络设置中 vEthernet switch 或者 vEthernet wsl 的 ip 地址。

假设该 ip 为 192.168.186.222

```bash
# listenport: 对外开放的端口
# connectaddress: wsl 的内部 ip
# connectport: wsl 的 ssh 端口
netsh interface portproxy add v4tov4 listenport=50022 connectaddress=192.168.186.222 connectport=22 listenaddress=* protocol=tcp 

# 删除端口转发
netsh interface portproxy delete v4tov4 listenport=80 protocol=tcp
```

在 windows 的防火墙高级设置中，在入规则中开放 50022 端口。

## 配置 ssh

```bash
# 重新安装 ssh
apt uninstall openssh-server
apt update # 有的 ubuntu 内核已经很旧了，会导致 install 时出现 url 失效的问题
apt install openssh-server

# ssh 的配置文件
/etc/ssh/sshd_config
# 本地用户的 ssh 目录
chmod 700 -R ~/.ssh 
chmod 600 ~/.ssh/authorized_keys
chown user:user -R ~/.ssh
```