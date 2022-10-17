---
title: wsl 数据迁移
date: 2022-10-18 01:27:01
tags:
- wsl
categories:
- wsl
---

wsl 数据迁移到其他硬盘

<!--more-->

wsl 的默认目录 `C:\Users\kimroniny\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc`

```bash
# 查看所有的 wsl
wsl -l -v 
# 导出想要迁移的 wsl 到 tar
wsl --export Ubuntu-18.04 D:\wsl\Ubuntu.tar
# 注销想要迁移的 wsl, 此时原目录下的数据 ./LocalState 就消失了
wsl --unregister Ubuntu-18.04
# 导入到指定目录
wsl --import Ubuntu-18.04 D:\wsl\wsl2 D:\wsl\Ubuntu.tar --version 2
# 设置默认登录用户为指定用户
ubuntu1804 config --default-user kimroniny

```