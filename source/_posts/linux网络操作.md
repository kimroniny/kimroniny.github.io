---
title: linux网络操作
date: 2020-08-04 14:24:50
tags:
- linux
- network
categories:
- linux
- network
---

关于 linux 的一些网络操作。

<!--more-->

下面是几个常用的命令来查看网络信息

```bash
ifconfig # 查看网卡

netstat -rn # 查看路由表，可以看到网关和子网掩码

arp -n # 查看近期的网络链接缓存，如果最近有其他ip访问你这台机器，那执行该命令的输出结果中就包含该ip的相关信息

ifquery -a --list # 列出所有的网卡名称

traceroute IP地址 # 连接到ip地址，需要经过的路由。
```

关于Ubuntu桌面版进行网络配置的注意事项:
1. 因为是桌面版，所以增加了network-manager来执行可视化的网络管理（就是在桌面UI中管理网络配置），配置文件是那个 `/etc/NetworkManager/NetworkManager.conf`，操作服务是 `service network-manager restart`；
2. 同时在命令行中依旧存在着管理网络的方式，配置文件是`/etc/network/interfaces`，操作服务是`service networking retart`。
3. 所以说，如果两个类型的网络管理服务出现了冲突，那么Ubuntu采用的处理方式是，以network-manager的配置为准，在network-manager一直负责网络配置的过程中，修改`/etc/network/interfaces`是没有意义的，所以如果想使用`/etc/network/interfaces`的配置，就需要让network-manager摆脱对网络配置的管理（直接stop掉network-manager，或者修改network-manager的配置文件managed子项为false，在下面有详细命令）。


以下是对网络进行配置的相关操作（适用于ubuntu 16，ubuntu 18）
```bash
/etc/NetworkManager/NetworkManager.conf # network-manager服务的配置文件，修改managed子项，从true改为false，可以关闭网络桌面管理工具对网络配置管理
# managed=false

sudo service network-manager restart # 重启网络桌面管理工具，会发现右上角的网络链接出现了问题。

# 以上两步也可以不做，可以直接关闭 network-manager
# sudo service network-manager stop
# 然后再使用下面的interfaces从命令行配置网络

/etc/network/interfaces # 网络配置文件
# auto lo
# iface lo inet loopback
# 上面的是文件本身自带的，下面的是自己添加的
# auto ens33
# iface ens33 inet static
# address 192.168.5.133     地址
# netmask 255.255.255.0     子网掩码
# gateway 192.168.5.1       网关

sudo ip addr flush dev 网卡名 # 刷新ip地址

sudo service networking restart # 重启所有网卡，看下service文件就是使用的 ifup 命令

```

**刷新ip地址的时候必须要注意，修改网络配置文件之后或者恢复network-manager接管必须执行这个，否则不会生效，需要重启才能使修改后的网络配置文件生效。**

查看一下`networking.service`的源码，可以发现本质上`networking`命令就是调用了`if up/down 网卡名`。

![networking.service](network-service.jpg)

