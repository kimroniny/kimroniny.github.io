---
title: linux挂载U盘
date: 2020-08-16 09:49:39
tags: 
- linux
categories:
- linux
- mount
---

在linux服务器上使用命令挂载和卸载U盘

<!--more-->

## Ubuntu

### mount


命令
```shell
mount [-t vfstype] [-o options] device dir
```

|cmd  |描述  |详细  |
|---------|---------|---------|
|-t vfstype|指定文件系统的类型，通常不必指定。mount 会自动选择正确的类型。|常用类型有：光盘或光盘镜像：iso9660;</br>DOS fat16文件系统：msdos;</br>Windows 9x fat32文件系统：vfat;</br>Windows NT ntfs文件系统：ntfs;</br>Mount Windows文件网络共享：smbfs;</br>UNIX(LINUX) 文件网络共享：nfs;|
|-o options|描述设备或档案的挂接方式|常用的参数有: loop：用来把一个文件当成硬盘分区挂接上系统;</br>ro：采用只读方式挂接设备;</br>rw：采用读写方式挂接设备;</br>iocharset：指定访问文件系统所用字符集;|
|device|要挂接(mount)的设备|使用`fdisk -l`来查询|
|dir|设备在系统上的挂接点|         |

```shell
sudo fdisk -l # 查看硬盘分区情况，根据硬盘大小找到U盘

mkdir -p /mnt/usb # 创建挂载点，挂载完成后，U盘里面的内容在这里显示

mount -t vfat /dev/sdd1 /mnt/usb # 把U盘设备 /dev/sdd1 挂载到挂载点上

mount -t vfat -o iocharset=cp936 /dev/sdd1 /mnt/usb # 如果中文名不显示或者为乱码
```

[参考链接](https://www.jb51.net/os/RedHat/1109.html)

### umount

命令:
```shell
umount [-ahnrvV][-t <文件系统类型>][文件系统]
```

|参数  |说明  |详细  |
|---------|---------|---------|
|-r|若无法成功卸除，则尝试以只读的方式重新挂入文件系统。|         |
|-v|执行时显示详细的信息。|         |
|-l|执行延迟卸载|延迟卸载（lazy unmount）会立即卸载目录树里的文件系统，等到设备不再繁忙时才清理所有相关资源|

```shell
umount -v /mnt/mymount/      # 通过挂载点卸载 
umount -v /dev/sda1          # 通过设备名卸载 

# 如果遇到设备繁忙的问题
lsof | grep mymount          # 查找mymount分区里打开的文件  
umount -vl /mnt/mymount/     # 执行延迟卸载 
```
