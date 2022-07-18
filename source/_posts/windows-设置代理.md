---
title: windows 设置代理
date: 2019-11-30 23:18:25
tags: 
- proxy
- windows
categories:
- windows
---

在Windows中设置本地代理

<!--more-->

1. 命令行

```bash
set HTTP_PROXY=http://user:password@proxy.domain.com:port
set HTTP_PROXY=http://127.0.0.1:12639
set HTTPS_PROXY=http://127.0.0.1:12639
```

2. 系统变量

创建两个系统变量

```python
HTTP_PROXY
HTTPS_PROXY
# 内容：http://127.0.0.1:12639
```