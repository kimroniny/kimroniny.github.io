---
title: linux开启端口
date: 2020-04-11 10:31:45
tags: 
- linux
categories:
- linux
- port
---

关于linux系统中端口的那些事儿

<!--more-->



# 打开端口

首先看云服务器控制台安全组规则是否允许打开该端口

然后在服务器上两种方式打开端口（Centos升级到7之后，内置的防火墙已经从iptables变成了firewalld）

### centos

**防火墙**

```bash
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


### ubuntu

使用`ufw`

```bash
# install
sudo apt-get install ufw

# start and stop
sudo ufw enable
sudo ufw disable

# status
sudo ufw status verbose

# open port
### 允许ssh连接22端口
sudo ufw allow ssh
### 允许 HTTP 连接：
sudo ufw allow http
### 也可以直接指定端口号 80：
sudo ufw allow 80/tcp
### 也可以使用应用程序配置文件，在本例中为「Nginx HTTP」：
sudo ufw allow 'Nginx HTTP'
### 允许 HTTPS 连接：
sudo ufw allow https
### 也可以直接指定端口号 443：
sudo ufw allow 443/tcp
### 也可以使用应用程序配置文件，在本例中为「Nginx HTTPS」：
sudo ufw allow 'Nginx HTTPS'
### 打开8080端口
sudo ufw allow 8080/tcp

# deny port
### both tcp and udp
sudo ufw deny 53
### only tcp
sudo ufw deny 53/tcp

# delete rule
sudo ufw delete deny 80/tcp
sudo ufw delete allow 53/udp

# add port range, use ":"
ufw allow 11200:11299/tcp
```

### linux原始

**iptables**

```
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 4000 -j ACCEPT
```
