---
title: ubuntu18部署gitlab
date: 2020-08-04 09:32:36
tags:
- gitlab
categories:
- gitlab
---

部署私人git服务器

<!--more-->

1. 安装gitlab还挺占存储空间的，主要是 `/` 目录下的空间，大概要允出 2 个多G的空间。

2. 另外一个就是找个网络不错的地方，要下载 800+M 的archives。

3. 服务器内存要足够大，大概要8个G左右（之前虚拟机配置了4个G内存，依旧不能运行成功）。

## 安装

```bash
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates
sudo apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
export EXTERNAL_URL="http://本机IP地址" 
sudo apt-get install gitlab-ee
# 指定版本
# sudo apt-get install gitlab-ee=版本
```
> 具体版本查看: [https://packages.gitlab.com/gitlab/gitlab-ee](!https://packages.gitlab.com/gitlab/gitlab-ee)

如果EXTERNAL_URL配置错误，就修改文件 `/etc/gitlab/gitlab.rb` 中的EXTERNAL_URL，然后执行下面的命令
```
gitlab-ctl reconfigure
```

## gitlab-ctl基本操作

```bash
gitlab-ctl start/stop/restart/status/reconfigure
```

## 查看gitlab版本

```bash
cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
```

## 卸载gitlab

```bash
sudo apt remove gitlab-ee
sudo pkill -f gitlab
sudo rm -rf /etc/gitlab
sudo rm -rf /var/opt/gitlab
sudo rm -rf /opt/gitlab
```

## 迁移服务器内容

直接参考官网链接来弄: [https://docs.gitlab.com/ee/raketasks/backup_restore.html](!https://docs.gitlab.com/ee/raketasks/backup_restore.html)

## Tips

1. clone的时候，如果使用`git@****`，那么链接的是服务器的22端口，所以服务器防火墙要开放22端口
2. 同样是clone的时候，当然不限于clone操作，都会要求密码，所以说需要在你的git账户里添加ssh_key，`ssh-keygen -t rsa -b 2048 -C "email@example.com"
`