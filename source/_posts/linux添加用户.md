---
title: linux添加用户
date: 2020-08-01 15:21:52
tags:
- linux
categories:
- linux
---

linux添加用户的命令

<!--more-->

## 使用adduser

**添加用户**

```bash
# 添加用户，并创建用户文件夹
adduser guo
```

**切换用户**
```bash
su guo
```

**删除用户**
```bash
userdel -r guo # -r 同时删除用户目录
```

**添加root权限**

修改 `/etc/sudoers` 文件，在 `root ALL=(ALL:ALL) ALL` 后面添加 `guo ALL=(ALL:ALL) ALL`

**添加某项权限**

修改 `/etc/sudoers` 文件，添加 `username ALL = NOPASSWD : /usr/bin/apt-get, /usr/bin/aptitude`

**查看用户权限**

```bash
sudo -l -U username
```

**修改密码**

```bash
passwd
```

**查看所有用户**
```bash
cat /etc/passwd|grep -v nologin|grep -v halt|grep -v shutdown|grep -v sync|grep -v syslog|awk -F":" '{ print $1"|"$3"|"$4 }'|more
```