---
title: linux查看系统配置
date: 2020-08-17 15:38:21
tags:
- linux
categories:
- linux
- system
---

从命令行查看系统配置

<!--more-->

## Ubuntu

命令： lshw

linux查看设备命令

系统
```shell
uname -a               # 查看内核/操作系统/CPU信息
head -n 1 /etc/issue   # 查看操作系统版本 
cat /proc/cpuinfo      # 查看CPU信息
hostname               # 查看计算机名 
lspci -tv              # 列出所有PCI设备
lsusb -tv              # 列出所有USB设备 
lsmod                  # 列出加载的内核模块
env                    # 查看环境变量
```

资源
```shell
free -m                # 查看内存使用量和交换区使用量 
df -h                  # 查看各分区使用情况 
du -sh <目录名>        # 查看指定目录的大小 
grep MemTotal /proc/meminfo   # 查看内存总量
grep MemFree /proc/meminfo    # 查看空闲内存量
uptime                 # 查看系统运行时间、用户数、负载 
cat /proc/loadavg      # 查看系统负载
```

磁盘和分区
```shell
mount | column -t      # 查看挂接的分区状态 
fdisk -l               # 查看所有分区 
swapon -s              # 查看所有交换分区
hdparm -i /dev/hda     # 查看磁盘参数(仅适用于IDE设备) 
dmesg | grep IDE       # 查看启动时IDE设备检测状况
```

网络
```shell
ifconfig               # 查看所有网络接口的属性
iptables -L            # 查看防火墙设置 
route -n               # 查看路由表 
netstat -lntp          # 查看所有监听端口 
netstat -antp          # 查看所有已经建立的连接
netstat -s             # 查看网络统计信息
```

进程
```shell
ps -ef                 # 查看所有进程 
ps -ux                 # 查看当前用户进程
top                    # 实时显示进程状态
```


用户
```shell
w                      # 查看活动用户 
id <用户名>            # 查看指定用户信息 
last                   # 查看用户登录日志 
cut -d: -f1 /etc/passwd   # 查看系统所有用户 
cut -d: -f1 /etc/group    # 查看系统所有组 
crontab -l             # 查看当前用户的计划任务
```
服务
```shell
# 首先安装chkconfig
# apt-get install sysv-rc-conf
# cp /usr/sbin/sysv-rc-conf /usr/sbin/chkconfig
chkconfig --list       # 列出所有系统服务 
chkconfig --list | grep on    # 列出所有启动的系统服务
```

程序
```shell
rpm -qa                # 查看所有安装的软件包
```

常用命令整理如下：
```shell
dmidecode | grep -i ’serial number’ # 查看主板的序列号
service kudzu start ( or restart) # 用硬件检测程序kuduz探测新硬件
cat /proc/cpuinfo, dmesg | grep -i 'cpu', dmidecode -t processor # 查看CPU信息
cat /proc/meminfo, free -m, vmstat # 查看内存信息
cat /proc/pci # 查看板卡信息
lspci |grep -i 'VGA', dmesg | grep -i 'VGA' # 查看显卡/声卡信息
dmesg | grep -i 'eth', cat /etc/sysconfig/hwconf | grep -i eth, lspci | grep -i 'eth' # 查看网卡信息
lspci (相比cat /proc/pci更直观）# 查看PCI信息
cat /proc/bus/usb/devices  # 查看USB设备
cat /proc/bus/input/devices # 查看键盘和鼠标
fdisk & disk – l & df # 查看系统硬盘信息和使用情况
cat /proc/interrupts # 查看各设备的中断请求(IRQ)
uname -a # 查看系统体系结构
isalist –v, isainfo –v, isainfo –b # 查看及启动系统的32位或64位内核模式
```

测定当前的显示器刷新频率：/usr/sbin/ffbconfig –rev \?

查看系统配置：/usr/platform/sun4u/sbin/prtdiag –v

查看当前系统中已经应用的补丁：showrev –p

显示当前的运行级别：who –rH

查看当前的bind版本信息：nslookup –class=chaos –q=txt version.bind

dmesg | more 查看硬件信息
lspci 显示外设信息, 如usb，网卡等信息
lsnod 查看已加载的驱动
lshw
psrinfo -v 查看当前处理器的类型和速度（主频）
prtconf -v 打印当前的OBP版本号
iostat –E 查看硬盘物理信息(vendor, RPM, Capacity)
prtvtoc /dev/rdsk/c0t0d0s 查看磁盘的几何参数和分区信息
df –F ufs –o i 显示已经使用和未使用的i-node数目
isalist –v

对于“/proc”中文件可使用文件查看命令浏览其内容，文件中包含系统特定信息：
Cpuinfo 主机CPU信息
Dma 主机DMA通道信息
Filesystems 文件系统信息
Interrupts 主机中断信息
Ioprots 主机I/O端口号信息
Meninfo 主机内存信息
Version Linux内存版本信息

备注： proc – process information pseudo-filesystem 进程信息伪装文件系统

RPM

    在Linux 操作系统中，有一个系统软件包，它的功能类似于Windows里面的“添加/删除程序”，但是功能又比“添加/删除程序”强很多，它就是 Red Hat Package Manager(简称RPM)。此工具包最先是由Red Hat公司推出的，后来被其他Linux开发商所借用。由于它为Linux使用者省去了很多时间，所以被广泛应用于在Linux下安装、删除软件。下面就 给大家介绍一下它的具体使用方法。

1.我们得到一个新软件，在安装之前，一般都要先查看一下这个软件包里有什么内容，假设这个文件是：Linux-1.4-6.i368.rpm，我们可以用这条命令查看：

rpm -qpi Linux-1.4-6.i368.rpm

系统将会列出这个软件包的详细资料，包括含有多少个文件、各文件名称、文件大小、创建时间、编译日期等信息。

2.上面列出的所有文件在安装时不一定全部安装，就像Windows下程序的安装方式分为典型、完全、自定义一样，Linux也会让你选择安装方式，此时我们可以用下面这条命令查看软件包将会在系统里安装哪些部分，以方便我们的选择：

rpm -qpl Linux-1.4-6.i368.rpm

1. 选择安装方式后，开始安装。我们可以用rpm-ivh Linux-1.4-6.i368.rpm命令安装此软件。在安装过程中，若系统提示此软件已安装过或因其他原因无法继续安装，但若我们确实想执行安装命 令，可以在 -ivh后加一参数“-replacepkgs”：

rpm -ivh -replacepkgs Linux-1.4-6.i368.rpm

4.有时我们卸载某个安装过的软件，只需执行rpm-e <文件名>;命令即可。

5.对低版本软件进行升级是提高其功能的好办法，这样可以省去我们卸载后再安装新软件的麻烦，要升级某个软件，只须执行如下命令：rpm -uvh <文件名>;，注意：此时的文件名必须是要升级软件的升级补丁

6. 另外一个安装软件的方法可谓是Linux的独到之处，同时也是RMP强大功能的一个表现：通过FTP站点直接在线安装软件。当找到含有你所需软件的站点并 与此网站连接后，执行下面的命令即可实现在线安装，譬如在线安装Linux-1.4-6.i368.rpm，可以用命令： www.it165.net

rpm -i ftp://ftp.pht.com/pub/linux/redhat/...-1.4-6.i368.rpm

7. 在我们使用电脑过程中，难免会有误操作，若我们误删了几个文件而影响了系统的性能时，怎样查找到底少了哪些文件呢?RPM软件包提供了一个查找损坏文件的 功能，执行此命令：rpm -Va即可，Linux将为你列出所有损坏的文件。你可以通过Linux的安装光盘进行修复。

8.Linux系统中文件繁多，在使用过程中，难免会碰到我们不认识的文件，在Windows下我们可以用“开始/查找”菜单快速判断某个文件属于哪个文件夹，在Linux中，下面这条命令行可以帮助我们快速判定某个文件属于哪个软件包：

rpm -qf <文件名>;

9.当每个软件包安装在Linux系统后，安装文件都会到RPM数据库中“报到”，所以，我们要查询某个已安装软件的属性时，只需到此数据库中查找即可。注意：此时的查询命令不同于1和8介绍的查询，这种方法只适用于已安装过的软件包！命令格式：

rpm -参数　<文件名>;

 

APT-GET

apt-get update——在修改/etc/apt/sources.list或者/etc/apt/preferences之后运行该命令。此外您需要定期运行这一命令以确保您的软件包列表是最新的。
apt-get install packagename——安装一个新软件包（参见下文的aptitude） 
apt-get remove packagename——卸载一个已安装的软件包（保留配置文件） 
apt-get --purge remove packagename——卸载一个已安装的软件包（删除配置文件） 
dpkg --force-all --purge packagename 有些软件很难卸载，而且还阻止了别的软件的应用，就可以用这个，不过有点冒险。 
apt-get autoclean apt会把已装或已卸的软件都备份在硬盘上，所以如果需要空间的话，可以让这个命令来删除你已经删掉的软件 
apt-get clean 这个命令会把安装的软件的备份也删除，不过这样不会影响软件的使用的。 
apt-get upgrade——更新所有已安装的软件包 
apt-get dist-upgrade——将系统升级到新版本 
apt-cache search string——在软件包列表中搜索字符串 
dpkg -l package-name-pattern——列出所有与模式相匹配的软件包。如果您不知道软件包的全名，您可以使用“*package-name-pattern*”。
aptitude——详细查看已安装或可用的软件包。与apt-get类似，aptitude可以通过命令行方式调用，但仅限于某些命令——最常见的有安装和卸载命令。由于aptitude比apt-get了解更多信息，可以说它更适合用来进行安装和卸载。
apt-cache showpkg pkgs——显示软件包信息。 
apt-cache dumpavail——打印可用软件包列表。 
apt-cache show pkgs——显示软件包记录，类似于dpkg –print-avail。 
apt-cache pkgnames——打印软件包列表中所有软件包的名称。 
dpkg -S file——这个文件属于哪个已安装软件包。 
dpkg -L package——列出软件包中的所有文件。 
apt-file search filename——查找包含特定文件的软件包（不一定是已安装的），这些文件的文件名中含有指定的字符串。apt-file是一个独立的软件包。您必须 先使用apt-get install来安装它，然后运行apt-file update。如果apt-file search filename输出的内容太多，您可以尝试使用apt-file search filename | grep -w filename（只显示指定字符串作为完整的单词出现在其中的那些文件名）或者类似方法，例如：apt-file search filename | grep /bin/（只显示位于诸如/bin或/usr/bin这些文件夹中的文件，如果您要查找的是某个特定的执行文件的话，这样做是有帮助的）。

 

 

<span class="wp_key<a href=" http:="" www.it165.net="" edu="" ebg="" "="" target="_blank">wordlink_affiliate">ubuntu查看版本命令
方法一：
在终端中执行下列指令： cat /etc/issue
方法二：
使用 lsb_release 命令也可以查看 Ubuntu 的版本号，与方法一相比，内容更为详细。
执行指令如下： sudo lsb_release -a
方法三：
打开“系统监视器”，选择“系统”
Ubuntu查看版本命令
1. lshw
lshw命令显示详细硬件信息。
如果要用概要方式显示，可以加上short参数：lshw-short
要显示指定硬件信息，加上class(或C)参数：lshw -classmemory
2. sysstat
监测系统性能及效率的一组工具，这些工具对于我们收集系统性能数据，
比如CPU使用率、硬盘和网络吞吐数据。
3. lspci -v (相比cat/proc/pci更直观）
查看PCI信息，lspci 是读取 hwdata 数据库。
4. uname -a
查看系统体系结构。
5. dmidecode
查看硬件信息，包括bios、cpu、内存等信息
6. dmesg
显示内核缓冲区系统控制信息，如系统启动时的信息会写到/var/log/。
注：dmesg 工具并不是专门用来查看硬件芯片组标识的工具，
但通过这个工具能让我们知道机器中的硬件的一些参数；因为系统在启动的时候，
会写一些硬件相关的日志到 /var/log/message* 或/var/log/boot* 文件中。
7. lshal 和hal-device-manager
8. 查看 /proc
对于“/proc”中文件可使用文件查看命令浏览其内容，文件中包含系统特定信息：
Cpuinfo 主机CPU信息
Dma 主机DMA通道信息
Filesystems 文件系统信息
Interrupts 主机中断信息
Ioprots 主机I/O端口号信息
Meninfo 主机内存信息
Version Linux内存版本信息
查看CPU信息：cat /proc/cpuinfo 查看板卡信息：cat /proc/pci 查看内存信息：cat/proc/meminfo 查看USB设备：cat /proc/bus/usb/devices 查看键盘和鼠标：cat/proc/bus/input/devices 查看各设备的中断请求(IRQ)：cat/proc/interrupts
主板信息:
sudo demidecode | grep -i ‘serial number’

CPU信息:
cat /proc/cpuinfo
dmesg | grep -i ‘cpu’
sudo dmidecode -t processor

硬盘信息:
查看分区情况:
sudo fdisk -l

查看大小情况:
df -h

查看使用情况:
du -h
sudo hdparm -I /dev/sda
dmesg | grep sda

内存信息:
cat /proc/meminfo
dmesg | grep mem
free -m
vmstat
sudo dmidecode | grep -i mem

网卡信息:
dmesg | grep -i ‘eth’
lspci | grep -i ‘eth’

ethtool -i eht0
ethhool -k eth0
ethtool -g eth0

查看鼠标和键盘:
cat /proc/bus/input/devices

查看各设备的中断请求(IRQ):
cat /proc/interrupts

显卡信息:
lspci | grep -i ‘VGA’
dmesg | grep -i ‘VGA’

声卡信息:
查看声卡型号:
lspci | grep -i audio

查看型号ac97的声卡驱动模块:
modprobe -l | grep ac97

查看声卡信息:
cat /proc/asound/cards

查看alsa-utils本:
alsactl -v

查看内核alsa版本:
cat /proc/asound/version

声卡信息:
aplay -l

硬件信息之声卡:
sudo lshw -C sound

模块状态之声音:
lsmod | grep -i snd

alsa音频配置:
alsamixer

其他命令:
dmesg
lspci
mpstat(先安装sysstat: sudo spt-get install sysstat)  

[参考链接](https://blog.csdn.net/chuanyu/article/details/46611793)
