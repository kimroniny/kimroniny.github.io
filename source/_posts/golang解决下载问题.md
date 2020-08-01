---
title: golang解决下载问题
date: 2020-7-23 18:35:29
tags: 
- golang
categories:
- golang
---

golang解决下载问题

<!--more-->

```bash
go env -w GO111MODULE=on // 不打开这个的话，下面的代理无效，需要把golang更新到最新版（好像得大于1.12）
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/
```

