---
title: pip 更换源
date: 2020-04-10 22:17:48
tags:
- python
- pip
categories:
- python
- pip
---

pip 更换下载源

<!--more-->

### 临时更换

```bash
pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
```

### 全局更换

```
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

### 其他源

```bash
# 豆瓣
https://pypi.doubanio.com/simple/
# 阿里云    
https://mirrors.aliyun.com/pypi/simple/
# 清华大学
https://pypi.tuna.tsinghua.edu.cn/simple/
https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/
```