---
title: linux合盖电源设置
date: 2020-08-16 09:43:47
tags:
- linux
categories:
- linux
---

笔记本安装linux服务器关闭盖子不休眠。

<!--more-->

## Ubuntu

配置文件: `/etc/systemd/logind.conf`

配置说明:
- #HandlePowerKey按下电源键后的行为，默认power off
- #HandleSleepKey 按下挂起键后的行为，默认suspend
- #HandleHibernateKey按下休眠键后的行为，默认hibernate
- #HandleLidSwitch合上笔记本盖后的行为，默认suspend（改为ignore；即合盖不休眠）在原文件中，还要去掉前面的#

我的做法是，把以上内容全部修改为 `ignore`