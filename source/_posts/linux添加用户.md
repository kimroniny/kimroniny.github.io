---
title: linux添加用户
date: 2020-08-01 15:21:52
tags:
- linux
categories:
- linux
- user
---

linux添加用户的命令

<!--more-->


## Ubuntu

### 用户

基本操作

```bash
adduser guo # 添加用户，并创建用户文件夹
su guo # 切换用户
userdel -r guo # -r 同时删除用户目录
sudo -l -U username # 查看用户权限
passwd # 修改密码
cat /etc/passwd|grep -v nologin|grep -v halt|grep -v shutdown|grep -v sync|grep -v syslog|awk -F":" '{ print $1"|"$3"|"$4 }'|more # 查看所有用户
```

添加root权限

修改 `/etc/sudoers` 文件，在 `root ALL=(ALL:ALL) ALL` 后面添加 `guo ALL=(ALL:ALL) ALL`

添加某项权限

修改 `/etc/sudoers` 文件，添加 `username ALL = NOPASSWD : /usr/bin/apt-get, /usr/bin/aptitude`

### 用户组

基本操作
```shell
sudo groupadd [选项] 组名　　　#添加新的组
sudo groupdel [选项] 组名　　　#删除一个组
newgrp 目的用户组 # 如果一个用户同时属于多个用户组，那么用户可以在用户组之间切换，以便具有其他用户组的权限。
```

修改用户所在组

```shell
usermod -g 用户组 用户名 # 强行设置某个用户所在组，修改用户名组
usermod -G 用户组 用户名 # 把某个用户改为 group(s)，单纯修改所在组（不包含用户名组）
usermod -a -G 用户组 用户名 # 把用户添加进入某个组(s），注意：原来的用户组还存在
```

查看用户组

```shell
groups # 查看当前登录用户的组内成员
groups 52php # 查看52php用户所在的组，以及组内成员
whoami # 查看当前登录用户名 
/etc/group # 文件包含所有组
/etc/shadow or /etc/passwd # 系统存在的所有用户名 
```

### 更改权限

`chown [-R]  用户[:用户组] 文件或者目录`

```shell
chown -R name:group /usr/local # 更改文件夹权限
```

[参考链接 - 组/用户操作](https://www.cnblogs.com/52php/p/5677628.html)

[参考链接 - 更改权限](https://blog.csdn.net/LI_AINY/article/details/87971085)