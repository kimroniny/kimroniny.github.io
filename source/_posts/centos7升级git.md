---
title: centos7升级git
date: 2020-08-01 09:32:35
tags:
categories:
---

在centof7中升级git到最新版

<!--more-->

### 安装依赖

```bash
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc
yum install  gcc perl-ExtUtils-MakeMaker
```

### 卸载旧版本

```bash
yum remove git
```

### 下载新版本并安装

https://mirrors.edge.kernel.org/pub/software/scm/git/

```bash
cd /usr/local/src/
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.23.0.tar.xz
tar -xvf git-2.23.0.tar.xz
cd git-2.23.0/
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/profile
source /etc/profile
```

非root用户使用需要如下操作

```bash
echo "export PATH=$PATH:/usr/local/git/bin" >> ~/.bashrc
source ~/.bashrc
```