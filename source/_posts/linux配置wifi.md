---
title: linux配置wifi
date: 2020-08-16 22:15:37
tags:
- linux
categories:
- linux
- wifi
---

linux系统中配置wifi上网。

<!--more-->

## Ubuntu

```shell
# 首先安装这俩东西
sudo apt-get install wpasupplicant
sudo apt-get install network-manager
```

使用 `ifconfig` 命令查看wifi网卡是否存在，不存在的话，执行下面命令
```shell
sudo apt-get update   # 尽可能使用Ubuntu的原始软件源
sudo apt install broadcom-sta-dkms
```

安装wifi网卡之后，重启电脑，使用 `ifconfig` 命令查看wifi网卡名称。

修改文件 `/etc/netplan/50-cloud-init.yaml` ，如下：

```
network:
    renderer: NetworkManager // 网络管理渲染器
    ethernets:
        enp2s0:
            addresses:
            - 192.168.2.9/24
            dhcp4: false
            gateway4: 192.168.2.1
            nameservers:
                addresses: []
                search: []
    wifis: // 这里是wifi网卡的配置
        wlp3s0:
            addresses:
            - 192.168.2.10/24
            dhcp4: false
            gateway4: 192.168.2.1
            nameservers:
                addresses: []
                search: []
            access-points:
                "无线网络名称":
                        password: '无线网络密码'
        wlp3s1:
            dhcp4: true
            access-points:
                "feixun_458BB5":  // 第一行是wifi名称
                    password: "987654321"  // 第二行是wifi密码
                "4G_CPE_39E1":
                    password: "sscz090619"
                "kr's samsung":
                    password: "45880222"            
    version: 2
```

修改文件之后，执行如下命令：
```shell
sudo netplan try # Try to apply a new netplan config to running system, with automatic rollback
sudo netplan generate # Generate backend specific configuration files from
sudo netplan apply # Apply current netplan config to running system
```

[参考链接-wifi](https://www.cnblogs.com/free-ys/p/10162388.html)

[参考链接-netplan](https://netplan.io/examples/)