---
title: screen 基本用法
date: 2022-10-30 14:21:16
tags: 
- linux
- screen
categories:
- linux
---

screen 的基本用法

<!--more-->

```bash
yum install screen

screen -S name python test.py # screen -S <name> <cmd>

Ctrl a+d # 从 screen 中退出，但是不中断 screen

screen -r name # 回到名称为 name 的 screen

screen -d name # 将名称为 name 的 screen 离线

screen -ls # 查看所有的 screen 
```