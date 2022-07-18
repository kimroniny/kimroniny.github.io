---
title: linux压缩文件
date: 2020-08-16 22:04:52
tags:
- linux
categories:
- linux
- compress
---

linux中的压缩和解压缩

<!--more-->


|后缀|压缩  |解压缩  |
|---------|---------|---------|
|.rar|`rar a FileName.rar DirName`|`rar x FileName.rar`|
|.zip|`zip FileName.zip DirName`|`unzip FileName.zip`|
|.tar.bz||`tar jxvf FileName.tar.bz`|
|.tar.gz & .tgs|`tar zcvf FileName.tar.gz DirName`|`tar zxvf FileName.tar.gz`|
|.gz|`gzip FileName`|`gzip -d FileName.gz`|
