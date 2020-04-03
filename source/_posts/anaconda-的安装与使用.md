---
title: anaconda 的安装与使用
date: 2018-09-02 23:53:37
tags: 
- python
- Anaconda
categories:
- python
- Anaconda
---

安装和使用anaconda以及miniconda过程中遇到的问题

<!--more-->

## 安装

**问题1：** centos7.5 64位安装miniconda遇到报错： ```bunzip2: command not found```

**解决办法：**

 安装bzip2：
 ```
 yum install -y bzip2
 ```
 **问题2：** 加入系统path
 
 **解决办法（永久生效）：**
- 修改/etc/profile文件

 ```bash
vim /etc/profile
 ```

 - 将以下文本加入到该文件末尾

```bash
PATH=$PATH:/root/Anaconda3/bin
export PATH
```

- 输入以下命令激活PATH，否则是不起作用的（如果在安装cond的过程中已经选择了加入path，那么安装完之后如果不执行以下命令会发现conda依旧是```command not found```

```bash
source ~/.bashrc
```
