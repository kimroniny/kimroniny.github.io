---
title: linux修改时区
date: 2020-08-17 00:02:41
tags:
- linux
categories:
- linux
- timezone
---

在Linux系统中修改时区。

<!--more-->

## Ubuntu

```shell
date -R # 查看时区，结尾+8000是中国北京时区
```
### tzselect

修改时区使用 `tzselect` 命令。

修改完之后，执行如下命令复制文件。

```shell
cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
```

###  timedatectl

```shell
timedatectl set-timezone Asia/Shanghai
```

### 修改日期和时间

```
sudo date -s MM/DD/YY //修改日期
sudo date -s hh:mm:ss //修改时间
```

修改时间以后，修改硬件CMOS的时间

```shell
sudo hwclock --systohc
```