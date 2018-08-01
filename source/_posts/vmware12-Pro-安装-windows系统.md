---
title: vmware12 Pro 安装 windows系统
date: 2018-08-01 09:44:25
tags: VMware
categories: VMware
---
### 使用VMware虚拟机安装操作系统的一点经历

<!--more-->

之前使用VMware12 pro安装Windows系统毫无问题，但是昨天安装的时候却总是出现 `operating system not found`的情况。经过一番百度和Google，换了各种iso镜像文件，也删过网络适配器，调整过BIOS启动项，但是都以失败告终，最终在一篇博客上看到说，***VMware不支持各种 ghost 镜像，只能用原生系统文件，试验成功。***

> 
> 原生系统：[https://msdn.itellyou.cn/](https://msdn.itellyou.cn/)
> 

还有几个小技巧：

- 进入VMware 的 BIOS，右击系统名称，电源，固件。这样就不用像以前那样和VMware拼速度了。

目前还没有解决的问题：

- VMware usb3.0 接口 暂时不知道怎么改，试了集几种方法都有问题

