---
title: golang 理解
date: 2019-12-09 14:43:06
tags:
categories:
---

golang学习过程中的一些理解

<!--more-->

### channel

非缓冲: 每次写入chan，阻塞，执行下一个，读入时，同样阻塞，[返回原来的goroutine|执行下一个goroutine]