---
title: Anaconda更新下载源
date: 2020-04-18 23:15:55
tags:
- python
- Anaconda
categories:
- python
- Anaconda
---

Anaconda 更新下载源

<!--more-->

```bash
# 清除索引
conda clean -i
# url 不可以加引号
conda config --add channels  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
conda config --add channels  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
conda config --add channels  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
conda config --add channels  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
conda config --add channels  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
# 搜索时显示通道地址
conda config --set show_channel_urls yes 
```

