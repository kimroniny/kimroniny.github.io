---
title: npm 更换源，设置代理
date: 2020-04-10 22:16:18
tags:
- npm
categories:
- npm
---

npm 更换下载源，设置代理

<!--more-->

```bash
npm config set registry https://registry.npm.taobao.org/

# 设置代理
npm config set proxy http://192.168.1.100:8080
npm config set https-proxy http://192.168.1.100:8080

# 删除代理
npm config rm proxy
npm config rm https-proxy

# 查看设置
npm config get registry
```