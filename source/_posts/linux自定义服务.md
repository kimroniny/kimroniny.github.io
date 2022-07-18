---
title: linux自定义服务
date: 2020-08-01 21:28:10
tags:
- linux
categories:
- linux
- service
---

在linux系统中自定义 service 并设置开机启动。

<!--more-->

> ***Tip:*** SELinux prevents you from running a system service where the binary is in a user's home directory, or in your case, the root user's home directory. To fix the problem, copy the binary to a proper directory such as /usr/local/bin and call it from there.
<br/>
***Source**: [https://serverfault.com/questions/957084/failed-at-step-exec-spawning-permission-denied](https://serverfault.com/questions/957084/failed-at-step-exec-spawning-permission-denied)*


service 文件存放在 `/usr/lib/systemd/system/` 文件夹下

示例
```conf
[Unit]
Description=Frp Server Service
After=network.target

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/usr/bin/frps_start.sh
ExecReload=/usr/bin/frps_reload.sh
ExecStop=/usr/bin/frps_stop.sh

[Install]
WantedBy=multi-user.target
```

关于开机启动

```bash
systemctl enable servicename # 开机启动
systemctl disable servicename # 关闭开机启动
systemctl list-units --type=service # 列出已经启动的服务
```

详细参考: [https://www.cnblogs.com/wutao666/p/9781567.html](https://www.cnblogs.com/wutao666/p/9781567.html)