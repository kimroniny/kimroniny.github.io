---
title: git基本操作
date: 2019-12-01 10:07:46
categories:
- git
tags:
- git
---

关于git的基本指令和操作，方便查询
<!--more-->

### add时忽略某些文件

根目录添加```.gitignore```文件，逐行写入需要忽略的文件
```bash
touch .gitignore
```

### 配置本地用户名和邮箱

```bash
git config --local user.name ""
git config --local user.email ""
```

### 不用每次输入账号密码

```bash
git config --global credential.helper store
```