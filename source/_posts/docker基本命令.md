---
title: docker基本命令
date: 2020-04-18 23:27:55
tags: 
- docker
categories:
- docker
---

关于docker使用的一些基本命令

<!--more-->

### 镜像、容器、仓库的概念区分

![镜像容器仓库](docker_1.png)

### docker用户组加入当前用户
```bash
#添加docker用户组
sudo groupadd docker     
#将登陆用户加入到docker用户组中
sudo gpasswd -a $USER docker     
#更新用户组
newgrp docker     
#测试docker命令是否可以使用sudo正常使用
docker ps    
```
### docker镜像源

打开`/etc/docker/daemon.json`，添加如下信息

```python
{
    "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
```

### 基本命令

```shell
# -i 交互式; -t 在新容器内指定一个终端
docker run -i -t ubuntu /bin/bash
# 在交互式中，查看系统版本，都可以
cat /proc/version
cat /etc/lsb-release
uname -a
# 退出容器
exit
# 显示所有的容器
docker ps -a
# 查看容器的标准输出，2b1b7a428627是容器的ID号 
docker logs 2b1b7a428627
# 拉取镜像到本地
docker pull centos
# 停止容器
docker stop 2b1b7a428627
# 启动已经停止的容器
docker start 2b1b7a428627
docker restart 2b1b7a428627
# -d 是从后台运行容器
docker run -itd --name ubuntu-test ubuntu /bin/bash
# 进入放在后台的容器，当使用exit退出的时候，不会停止容器的运行
docker exec -it 2b1b7a428627 /bin/bash
# 导出容器
docker export 2b1b7a428627 > ubuntu.tar
# 导入容器
cat ubuntu.tar | docker import - ubuntu:v1
docker import http://example.com/exampleimage.tgz imagerepo
# 显示本地镜像
docker images
# 删除容器
docker rm -f 2b1b7a428627
```