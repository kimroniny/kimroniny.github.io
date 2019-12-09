---
title: golang 理解
date: 2019-12-09 14:43:06
tags:
categories:
---

golang学习过程中的一些理解

<!--more-->

### channel

从main函数开始，main函数不堵塞，轮不到goroutine

mian函数堵塞在 i := <- c

goroutine运行，channel c接收数据，c <- x1, 此时不会堵塞（因为main函数在接收数据，相当于抵消掉），
goroutine继续执行，channel c接收数据，c <- x2，此时len(c) > cap(c)，goroutine堵塞，需要跳转到另一个goroutine，
从而把数据消掉，于是跳转到了main，而此时main函数正在处理的数据是x1，然后继续循环执行到 i := <- c，此时获取x2，
然后继续执行到 i := <- c, 因为channel没有数据了，所以堵塞，转到goroutine。

综合理解：从channel中取数据时，没有数据就阻塞，有数据就继续执行；向channel中写数据时，如果没有goroutine等着接收数据，则阻塞，
如果有，则继续执行。

可以理解为三部分: [ 抵消值 | 缓冲区 | 阻塞值 ]

先满足抵消值，再填充缓冲区，然后到达阻塞值处，当前goroutine阻塞，跳转到另一个goroutine。