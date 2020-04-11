---
title: linux开启端口
date: 2020-04-11 10:31:45
tags: 
- linux
categories:
- linux
---

关于linux系统中端口的那些事儿

<!--more-->

### 打开端口

首先看云服务器控制台安全组规则是否允许打开该端口

然后在服务器上两种方式打开端口（Centos升级到7之后，内置的防火墙已经从iptables变成了firewalld）

**防火墙**

```
# 防火墙的启动关闭
systemctl status firewalld
systemctl start firewalld
systemctl restart firewalld
systemctl stop firewalld
# 打开端口
firewall-cmd --zone=public --add-port=4000/tcp --permanent 
# 关闭端口
firewall-cmd --zone=public --remove-port=4000/tcp --permanent
# 重启防火墙
firewall-cmd --reload
# 查询指定端口
firewall-cmd --query-port=4000/tcp 
# 查询所有端口
firewall-cmd --list-all 
```

**iptables**

```
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 4000 -j ACCEPT
```