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

1. 安装gitlab还挺占存储空间的，主要是 `/` 目录下的空间，大概要允出 5-10 个G的空间。

2. 另外一个就是找个网络不错的地方，要下载将近1G的安装包。

3. 服务器内存要足够大，大概要8个G左右（之前虚拟机配置了4个G内存，依旧不能运行成功）。

其他的按照官网教程来就行。

```bash
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates
sudo apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
sudo EXTERNAL_URL="https://本机IP地址" apt-get install gitlab-ee
```

如果EXTERNAL_URL配置错误，就修改文件 `/etc/gitlab/gitlab.rb` 中的EXTERNAL_URL，然后执行下面的命令
```
gitlab-ctl reconfigure
```

查看gitlab的状态

```bash
gitlab-ctl status
```

