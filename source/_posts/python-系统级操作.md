---
title: python 系统级操作
date: 2019-12-05 10:23:05
tags: 
- python
- os,sys
categories:
- python
- os, sys
---

关于python中对系统的一些操作，比如os模块等等

<!--more-->

## 模块 os

```python
import os

filepath = os.path.abspath(__file__)
os.path.exists(filepath)

os.path.isfile(filepath)
os.path.isdir(filepath)

os.mkdir() # 单级目录
os.makedirs() # 多级目录

```

## 模块 sys

```python
import sys

sys.path.append()

```

## 模块 subprocess

```python
import subprocess

res = subprocess.Popen(['cmd1', 'cmd2', ], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
err = res.stderr.read().decode('gbk')
out = res.stdout.read().decode('gbk')
# read() 只能读取一次
```