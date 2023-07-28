---
title: wsl-代理问题
date: 2023-07-28 10:28:14
tags:
- wsl
categories:
- wsl
---

wsl 设置代理时遇到的问题

<!--more-->

```bash
export HTTP_PROXY=http://${cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'}:7890
export HTTPS_PROXY=http://${cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'}:7890
```

如果无法访问宿主机ip, 可能是因为宿主机的防火墙没有打开

```bash
New-NetFirewallRule -DisplayName "WSL" -Direction Inbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow
```