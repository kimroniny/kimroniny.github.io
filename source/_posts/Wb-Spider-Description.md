---
title: wb爬虫项目介绍
date: 2020-03-06 11:08:08
tags: [spider,weibo,scrapy,private] 
categories:
---

微博爬虫项目说明文档

<!--more-->

- [1. 服务器概况](#1-%e6%9c%8d%e5%8a%a1%e5%99%a8%e6%a6%82%e5%86%b5)
  - [1.1. 整体架构](#11-%e6%95%b4%e4%bd%93%e6%9e%b6%e6%9e%84)
  - [1.2. 服务器配置信息](#12-%e6%9c%8d%e5%8a%a1%e5%99%a8%e9%85%8d%e7%bd%ae%e4%bf%a1%e6%81%af)
  - [1.3. 服务期间工作流程](#13-%e6%9c%8d%e5%8a%a1%e6%9c%9f%e9%97%b4%e5%b7%a5%e4%bd%9c%e6%b5%81%e7%a8%8b)
    - [1.3.1. 关于IP代理](#131-%e5%85%b3%e4%ba%8eip%e4%bb%a3%e7%90%86)
    - [1.3.2. 关于其他服务](#132-%e5%85%b3%e4%ba%8e%e5%85%b6%e4%bb%96%e6%9c%8d%e5%8a%a1)
- [2. ADSL动态代理服务器](#2-adsl%e5%8a%a8%e6%80%81%e4%bb%a3%e7%90%86%e6%9c%8d%e5%8a%a1%e5%99%a8)
  - [2.1. 服务器信息](#21-%e6%9c%8d%e5%8a%a1%e5%99%a8%e4%bf%a1%e6%81%af)
  - [2.2. 服务器部署](#22-%e6%9c%8d%e5%8a%a1%e5%99%a8%e9%83%a8%e7%bd%b2)
    - [2.2.1. squid代理服务](#221-squid%e4%bb%a3%e7%90%86%e6%9c%8d%e5%8a%a1)
    - [2.2.2. 周期性拨号及发送代理IP服务](#222-%e5%91%a8%e6%9c%9f%e6%80%a7%e6%8b%a8%e5%8f%b7%e5%8f%8a%e5%8f%91%e9%80%81%e4%bb%a3%e7%90%86ip%e6%9c%8d%e5%8a%a1)
    - [2.2.3. python环境](#223-python%e7%8e%af%e5%a2%83)
    - [2.2.4. 如何添加新的 *adsl* 服务器？](#224-%e5%a6%82%e4%bd%95%e6%b7%bb%e5%8a%a0%e6%96%b0%e7%9a%84-adsl-%e6%9c%8d%e5%8a%a1%e5%99%a8)
- [3. 独立IP服务器](#3-%e7%8b%ac%e7%ab%8bip%e6%9c%8d%e5%8a%a1%e5%99%a8)
  - [3.1. 服务器信息](#31-%e6%9c%8d%e5%8a%a1%e5%99%a8%e4%bf%a1%e6%81%af)
  - [3.2. 服务器部署](#32-%e6%9c%8d%e5%8a%a1%e5%99%a8%e9%83%a8%e7%bd%b2)
    - [3.2.1. redis服务](#321-redis%e6%9c%8d%e5%8a%a1)
    - [3.2.2. 其他网络接口服务](#322-%e5%85%b6%e4%bb%96%e7%bd%91%e7%bb%9c%e6%8e%a5%e5%8f%a3%e6%9c%8d%e5%8a%a1)
    - [3.2.3. python环境](#323-python%e7%8e%af%e5%a2%83)
    - [3.2.4. 注意](#324-%e6%b3%a8%e6%84%8f)
- [4. 爬虫服务器](#4-%e7%88%ac%e8%99%ab%e6%9c%8d%e5%8a%a1%e5%99%a8)
  - [4.1. 目录说明](#41-%e7%9b%ae%e5%bd%95%e8%af%b4%e6%98%8e)
  - [4.2. 运行流程](#42-%e8%bf%90%e8%a1%8c%e6%b5%81%e7%a8%8b)
    - [4.2.1. 确保 *cookie* 有效](#421-%e7%a1%ae%e4%bf%9d-cookie-%e6%9c%89%e6%95%88)
    - [4.2.2. 运行必要的脚本](#422-%e8%bf%90%e8%a1%8c%e5%bf%85%e8%a6%81%e7%9a%84%e8%84%9a%e6%9c%ac)
    - [4.2.3. 填充检索文件](#423-%e5%a1%ab%e5%85%85%e6%a3%80%e7%b4%a2%e6%96%87%e4%bb%b6)
    - [4.2.4. 运行程序](#424-%e8%bf%90%e8%a1%8c%e7%a8%8b%e5%ba%8f)

# 1. 服务器概况

## 1.1. 整体架构

![整体架构](1.jpg)
## 1.2. 服务器配置信息
<table>
    <tr>
        <th>类型</th>
        <th>服务器地址</th>
        <th>购买日期</th>
        <th>到期时间</th>
        <th>登录</th>
    </tr>
    <tr>
        <td>独立IP服务器</td>
        <td>69.165.65.191:22</td>
        <td>2020.02.04</td>
        <td>2020.03.06</td>
        <td>root<br><i>e53f0c66ebb8</i></td>
    </tr>
    <tr>
        <td rowspan='3'>ADSL动态代理服务器</td>
        <td>lflt01.yunpptp.cn:20033</td>
        <td>2020.02.05</td>
        <td>2020.03.07</td>
        <td>root<br><i>1aikimroniny</i></td>
    </tr>
    <tr>
        <td>lflt01.yunpptp.cn:20029</td>
        <td>2020.02.05</td>
        <td>2020.03.07</td>
        <td>root<br><i>1aikimroniny</i></td>
    </tr>
    <tr>
        <td>lflt01.yunpptp.cn:20021</td>
        <td>2020.02.04</td>
        <td>2020.03.06</td>
        <td>root<br><i>1aikimroniny</i></td>
    </tr>
    <tr>
        <td>清华服务器（爬虫服务器）</td>
        <td>101.6.240.197:22</td>
        <td>无</td>
        <td>无</td>
        <td>kimroniny<br><i>kimroniny123456</i></td>
    </tr>
</table>

## 1.3. 服务期间工作流程
### 1.3.1. 关于IP代理

每个ADSL动态代理服务器（以下简称adsl服务器）使用squid部署认证代理服务，并且都有设置好的脚本程序，定期拨号更换IP，然后将新的IP地址发送给独立IP服务器（以下简称独立服务器）。
独立服务器会将收到的IP地址保存在本机redis缓存中。
清华服务器（爬虫服务器）（以下简称爬虫服务器）中设置脚本程序，周期向独立服务器请求IP池，并保存在本机redis中。

### 1.3.2. 关于其他服务
为了方便检测爬虫服务器抓取数据的情况，爬虫服务器将本机Mongo数据库中的数据量周期性发送给独立服务器，独立服务器将其保存在本机redis缓存中，等待用户从浏览器中访问。
# 2. ADSL动态代理服务器
提示: 一定要注意服务器的到期时间，否则程序挂掉，又得重新部署，当然如果你很熟练的话就随便了。
## 2.1. 服务器信息
目前选择的是云立方( https://www.yunlifang.cn/ )，很多的ADSL拨号服务器不支持代理，也就是拨号后的IP不能作为公网IP被访问到（因此前期搭服务器的时候吃了很多亏），云立方恰好可以解决这个问题，所以也比较贵。
登录云立方的网站，账号密码如下：

| 账号      | 密码         |
| --------- | ------------ |
| kimroniny | 80ddf688d031 |

查看云VPS服务器信息，点击“操作”，可以进行续费。

![云立方服务器](2.png)
 
## 2.2. 服务器部署
### 2.2.1. squid代理服务
普通的服务器是无法做代理服务器的，必须部署代理服务，这里选择的是squid来进行金部署。
squid的默认代理端口是3128，所以服务器必须打开防火墙，允许通过该端口3128，命令如下：
```bash
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 3128 -j ACCEPT
```
启动squid服务之后，该服务器才能作为代理做跳板使用。关于squid的命令如下：
```bash
yum install squid		# 安装squid
service squid start		# 启动服务
service squid restart	# 重启服务
service squid status	# 检查squid服务的状态
```
squid的配置文件和日志文件存放位置：
```bash
/etc/squid/squid.conf	# 配置文件，如果需要改动配置文件最好先备份一下
/var/log/squid/			# 该文件夹下存放的都是访问日志之类的
```
配置文件我会保存一份在爬虫服务器爬虫项目 `/WeiboSpider/bak/` 文件夹下，如果需要重新部署，方便复制。
squid默认是没有用户名密码认证的，但是为了防止被恶意程序扫描到，这里使用了简单认证代理，用户密码如下：

|  账号            |  密码                  |
| ----  | ---- |
|  kimroniny  |  1aikimroniny  |

设置简单认证代理的话，需要执行下面命令：
```bash
yum install httpd	# htpasswd命令需要httpd工具包
htpasswd -b -c /etc/squid/pwd kimroniny 1aikimroniny
# /etc/squid/pwd是生成的密钥文件，执行指令之后你可以打开看看里面的内容
# kimroniny是用户名
# 1aikimroniny 是密码
```
执行以上命令之后，squid的配置文件中与之有关的是下面几行，这几行代码在 `/WeiboSpider/bak/squid.conf` 中有，可以自行查阅，也可以到各个adsl服务器上查看配置文件。
```bash
# 上面这一行是指定选择的认证方式为basic，认证程序路径和密码文件路径
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/pwd
# 认证程序的进程数
auth_param basic children 5					
# 指定用户名
auth_param basic realm kimroniny Squid		
# 认证的有效时间
auth_param basic credentialsttl 5 hours 	
# 设置允许认证的用户访问
acl kimroniny proxy_auth REQUIRED
http_access allow kimroniny					
http_access deny all
```
### 2.2.2. 周期性拨号及发送代理IP服务
脚本程序就放在了根目录下。
```bash
# 文件名末尾的数字不同的服务器不一样
/root/sender_adsl0000.py	
```
一般的话，是一直在运行的，可以通过以下命令来查看是否还在运行。
```bash
ps -ux | grep sender_adsl
```
如果有红框里面的东西就说明还在运行。
![缩略图](3.png)
 
目前程序是每个40秒会重新拨号生成新的IP地址，然后发送给独立服务器。
### 2.2.3. python环境
```bash
# python版本
version 2.7.5
# 需要的packages
pip install requests
```
### 2.2.4. 如何添加新的 *adsl* 服务器？
如果觉得三台adsl服务器不够用的话，可以在该官网上继续购买，不需要太好的配置，因此我买的是下面这款。有时候库存不够，就换个别的就行。
![adsl服务器类型](4.png) 
由于云立方的服务器初始化环境确实挺垃圾，所以在安装其他内容之前需要进行一些初始操作，命令如下：
```bash
yum clean all
yum install epel-release
yum update
# 服务器并没有pip程序，所以需要自己安装
yum install python-pip
```
接下来就是安装 *squid* 服务，并设置基本认证。
然后安装 *python* 环境（需要的 *packages* ）。
创建 `sender_adsl0003.py`，注意这里的 *0003* 是有要求的，服务器的编号从 *0000* 开始，然后是 *0001* , *0002* ,所以再添加服务器就是第 *4* 台服务器，这里文件名就是 *0003*，然后该文件的内容和其他的 *adsl* 服务器上的 `sender_adsl000*.py` 的内容一致，但是需要找到下面这条语句并进行修改：
```python
os.system('adsl-stop')
os.system('adsl-start')
r = requests.post(url, data={'name':'adsl-0002'})// 按照规律修改此处的编号
cnt += 1
```
这里的参数 *`name`* 是独立服务器上在 *redis* 中记录对应服务器 *IP* 的 *key* （键值），所以各个服务器要保持不一致，且格式为 *`adsl*`* 的格式，查看独立服务器中的 `receiver.py` 程序就知道为什么了。
程序文件创建成功后，直接后台运行即可，注意，要用 `nohup [command] &` 的格式来执行程序，避免程序在用户退出终端关闭shell后被杀掉。
```bash
nohup python sender_adsl0003.py &
```
# 3. 独立IP服务器
## 3.1. 服务器信息
这个服务器具有固定的公网IP，其他的服务器都可以访问到，所以可以借助这个特性在上面多部署一些服务。
独立IP的服务器淘宝上很多，我买的是香港的这个辰迅云(https://www.chenxunyun.com/)。
网站的登录账号和密码如下（没错，很多网站的账号密码都是差不多的）：
|账号|密码|
|-|-|
|kimroniny|1aikimroniny|
查看服务器信息，也是一定要注意过期问题。
 
## 3.2. 服务器部署
### 3.2.1. redis服务
用来存储adsl服务器发送来的IP池，以及爬虫服务器发送来的数据量。
主要使用命令：
```bash
yum install redis	# 安装redis
service redis start	# 启动
service redis restart	# 重启
service redis status	# redis运行状态
redis-cli		# 进入redis命令行模式
```
### 3.2.2. 其他网络接口服务
（1） *`api.py`*。使用 *tornado* 创建的对外开放的数据浏览服务，目前主要是两个网址，具体如下：
```bash
# 查看主题检索的数据获取情况
http://69.165.65.191:8887/info/topic	
# 查看关键字检索的数据获取情况
http://69.165.65.191:8887/info			
```

（2） *`check_adsl_active.py`*。检测 *adsl* 服务器的存活状态，因为 *adsl* 服务器每间隔40秒就向独立服务器发送一次请求，独立服务器将其IP存储在本机 *redis* 中，而该程序每隔10分钟检测新IP是否和旧IP一致，若一致则说明 *adsl* 服务器很可能出现了问题。

（3） *`receiver.py`*。使用 *tornado* 创建的代理IP接受服务，接收来自 *adsl* 服务器的请求，然后获取其IP保存在对应的 *redis* 键值中，同时接收来自爬虫服务器的请求，将本机的IP池返回给爬虫服务器。
### 3.2.3. python环境
```bash 
# python版本
version 2.7.5
# 需要的packages
pip install requests
pip install tornado==5.1.1
pip install redis
```

### 3.2.4. 注意
登录该独立服务器的时候，不要骂娘，没错，他就是那么卡顿，当然，如果你想换到别的服务器上也很简单，把上面的程序该安装的安装，该执行的执行了就行了，注意，执行网络接口服务的时候，要采用 `nohup [command] &` 的格式来执行，同时要修改adsl服务器中的 `sender_adsl000*.py` 程序中的 *url* 。
```bash
# 很好理解，独立服务器的ip地址变了，肯定要重新设置url
url = 'http://69.165.65.191:8888/'
```
# 4. 爬虫服务器
服务器用的你们自己的清华服务器，不用多说了，但是有个建议，可以参考这篇帖子 https://blog.csdn.net/enzesheng/article/details/42319117 改一下快捷键，，这样在命令行敲几个字母，然后 *page up* 或者 *page down* ，就可以调出以这几个字母为前缀的历史命令，非常好用。
## 4.1. 目录说明
在 *markdown* 里面不太方便编辑，放在幕布里面了，链接如下：
```
链接: https://mubu.com/doc/3m1WiXfr_o 密码: amqg
```


## 4.2. 运行流程
以下所有操作，均需要切换到项目根目录下，即 `/project/WeiboSpider/` 下进行运行。
### 4.2.1. 确保 *cookie* 有效
查看数据库 *Sina* 中的 *account* 表中是否有 *cookie*，如果没有，需要重新抓取，具体抓取方法如下：

（1）	环境需求： *linux* 桌面版， *firefox* 浏览器， *MongoDB* 数据库， *python* 依赖包（ *pymongo* 以及 *selenium* ）

（2）	这一块得在 *linux* 桌面版上运行抓取，因为登录用户和密码的过程中，需要人为验证（这一块现在微博搞得无法直接登录，必须得有验证，验证方式采用的是 *GeeTest* 极验，不好破解，而且破解也没有意义，稍微更换些参数就没有意义了）。机器上必须安装 *MongoDB* ，抓取 *cookie* 后直接放到 *MongoDB* 中了。还必须安装 *firefox* 浏览器，看到项目目录下的 *geckodriver* 了吗，这个就是针对 *firefox* 的组件，所以运行程序的时候这个也不能少哦。

（3）	在 `/sina/account_build/account.text` 中填充账号密码，按照 `/sina/account_build/account_sample.txt` 中的格式来搞。

（4）	直接运行 `login.py` 程序.
```bash
python sina/account_build/login.py
```

（5）	接下来程序就自己打开 *firefox* 浏览器，自动输入账号密码，自动登录，但是会遇到验证，这个时候你就需要按照验证方式进行验证就好了（一般就是让你点击哪哪哪）。

（6）	程序运行结束后你可以看到 *MongoDB* 中 *Sina* 中的 *account* 会有数据存在的
### 4.2.2. 运行必要的脚本
```bash
# 代理池请求服务，必须要有，否则爬虫运行没有代理，根本跑不起来
nohup python sina/scripts/iprequests.py &				
# 主题检索结果数据发送服务
nohup python sina/scripts/mongo_sender_topic.py &
# 关键字检索结果数据发送服务
nohup python sina/scripts/mongo_sender.py &
```
### 4.2.3. 填充检索文件
如果是抓取主题数据，就将主题放在 *sina/redis_init/hashtag.txt* 文件中，然后运行下面命令，将检索链接放在 *redis* 中；
```bash
python sina/redis_init/redis_init_topic.py
```
如果是抓取and关键字，就放在 *sina/redis_init/search_and.txt* 文件中，如果需要调整检索日期，就打开 `sina/redis_init/redis_init_and.py` 调整 *date_start* 和 *date_end* ，然后运行；
```bash
python sina/redis_init/redis_init_weibo_of_and.py
```
如果是抓取单个关键字，就放在 *sina/redis_init/search_and.txt* 文件中，如果需要调整检索日期，就打开 `sina/redis_init/redis_init_single.py` 调整 *date_start* 和 *date_end* ，然后运行；
```bash
python sina/redis_init/redis_init_weibo_of_single.py
```
### 4.2.4. 运行程序
如果是运行主题爬虫，则直接执行下面命令即可。
```bash
nohup scrapy crawl topic_spider > /dev/null 2>&1 &
```
如果是运行关键字爬虫，则需要添加参数，来指明是and型关键字还是单个型关键字。
```bash
# and型关键字
nohup scrapy crawl weibo_spider -a search_type=search_and > /dev/null 2>&1 &
# 单个型关键字
nohup sscrapy crawl weibo_spider -a search_type=search_single > /dev/null 2>&1 &
```
运行命令可以执行多次，相当于开多个进程同时抓取，因为咱们代理服务器只有三个，所以也不要开太多，开太多，代理很快也就挂掉了，开上三到五个进程就差不多了。





