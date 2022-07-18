---
title: linux开启ssh服务
date: 2020-08-01 16:18:30
tags:
- linux
categories:
- linux
- ssh
---

在Ubuntu和centos上开启ssh服务的过程

<!--more-->

## Ubuntu

```bash

sudo apt-get update
sudo apt-get install openssh-server
# 查看ssh状态
service ssh status
```

## Centos

```bash
yum install openssh-server
service sshd start
```

> 不要忘记开启22端口, {% post_link linux开启端口 点击这里查看这篇文章 %}

## 保存ssh-key，直接登录

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
把客户机的id_rsa.pub的内容append到authorized_keys文件
ssh-keygen -t rsa -b 2048 -C "email@example.com"
```