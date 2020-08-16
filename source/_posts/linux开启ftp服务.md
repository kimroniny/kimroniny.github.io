---
title: linux开启ftp服务
date: 2020-08-16 23:19:50
tags:
- linux
categories:
- linux
- ftp
---

在linux服务器上开启ftp服务。

<!--more-->

## Ubuntu

使用的软件: vsftpd
```shell
sudo apt-get install vsftpd
```

需要配置的文件: `/etc/vsftpd.conf`

首先备份一下该文件，然后创建新配置文件，并输入以下内容。

```conf
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
pasv_enable=Yes # 打开被动模式
pasv_min_port=10000 # 被动模式的端口
pasv_max_port=10100 # 被动模式的端口
allow_writeable_chroot=YES # 必须要有
```

操作服务
```
sudo service vsftpd start/restart/stop
```

使用该机器上的任意帐户登录即可，登录即到自己的用户帐户下。

关于ftp的两种工作模式：被动模式（PASV方式，passive）和主动模式（PORT方式）。

**必须用被动模式！！！**

FTP是仅基于TCP的服务，不支持UDP。默认情况下FTP协议使用TCP端口中的 20和21这两个端口，一个数据端口和一个命令端口（也可叫做控制端口），也就是20号端口用于传输数据，21号端口用于传输控制信息。但是，是否使用20作为传输数据的端口与FTP使用的传输模式有关，如果采用主动模式，那么数据传输端口就是20；如果采用被动模式，则具体最终使用哪个端口要服务器端和客户端协商决定。这就是主动与被动FTP的最大不同之处。

- 命令连接：当FTP客户端需要登陆到FTP服务器上的时候，服务器与客户端需要进行一系列的身份验证过程，这个过程就叫做命令连接。
- 数据连接：如果此时客户端需要往FTP服务器上上传或者下载文件的话，就需要在客户端与服务器端再建立一条额外的数据传输连接。

1. 主动模式。FTP客户端从任意的非特殊的端口（N >1024）连入到FTP服务器的命令端口——21端口。然后客户端在N+1端口监听，并且通过该N+1端口发送PORT命令给FTP服务器，接着服务器会从它自己的数据端口（20）连接到客户端指定的数据端口（N+1）。在主动传输模式下，FTP的数据连接和控制连接的方向是相反的，也就是说：是客户端向服务器建立控制连接，服务器向客户端建立数据连接，其中，客户端的控制连接和数据连接的端口号是大于1024的两个端口号（临时端口），而FTP服务器的数据端口为20，控制端口为21。</br></br>主动方式FTP的主要问题实际上在于客户端。FTP的客户端并没有实际建立一个到服务器数据端口的连接，它只是简单地告诉服务器自己监听的端口号，服务器再回来连接客户端这个指定的端口。**对于客户端的防火墙来说，这是从外部系统建立到内部客户端的连接，这是通常会被阻塞的。**

- C:N -> S:21
- connection success
- C open port N+1
- C:N+1 -> CMD: PORT -> S:21
- S:20 -> C:N+1

2. 被动模式。在被动方式FTP中，命令连接和数据连接都由客户端发起，只要求服务器端产生一个监听相应端口的进程，这样就可以解决从服务器到客户端的数据端口的入方向连接被防火墙过滤掉的问题。
</br></br>当开启一个FTP连接时，客户端随机打开一个大于1024的本地端口N向服务器的21号端口发起连接，同时会开启N+1号端口。然后向服务器提交 PASV命令，通知服务器自己处于被动模式。那么服务器收到命令后就会开启一个任意的非特权端口（P > 1024）监听，并发送PORT P命令给客户端通知自己的数据端口是P。然后客户端通过本地端口N+1连接到服务器的端口P的连接用来传送数据。在被动模式下，FTP的数据连接和控制连接的方向都是一致的，也就是说：是客户端向服务器发起一个用于数据传输的连接，客户端的连接端口是发起这个数据连接请求时使用的端口。客户端的控制连接和数据连接的端口号是大于1024的两个端口号（临时端口），而服务器端的数据端口是临时端口，而不一定是常规的20。

- C:N -> S:21
- connection success
- C open port N+1
- C:N -> CMD: PASV -> S:21
- S open random port P(P>1024)
- S:21 -> port P -> C:N
- C:N+1 -> S:P


[参考链接 - 配置](https://www.linuxidc.com/Linux/2018-08/153491.htm)

[参考链接 - 被动与主动](https://blog.csdn.net/qq_16038125/article/details/72851142)

[参考链接 - 被动与主动](https://blog.csdn.net/wumenglu1018/article/details/54233826)

[参考链接 - 被动与主动](https://blog.csdn.net/u010154760/article/details/45458219)