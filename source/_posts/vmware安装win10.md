---
title: VMware 安装 win10
date: 2020-07-13 10:05:34
tags: 
- vmware
categories:
- vmware
---

关于VMware安装win10的过程

<!--more-->

制作 U 盘启动器，把 diskgenius 软件的最新版放到U盘里，用于磁盘分区，格式转换；

vmware创建一个新的虚拟机 win10_test；

创建完成之后，打开 win10_test 的配置： 新建 -> 硬盘 -> SCSI -> 使用物理磁盘 -> PhysicalDriver1 -> 一路确定，

选择 `打开电源时进入固件`，进入 BIOS，调整启动顺序，启动PE系统；

在PE系统中，使用diskgenius`将磁盘转换为GUID格式`：硬盘 -> 转换分区表类型为GUID格式

接下来进行分区，安装系统即可。

