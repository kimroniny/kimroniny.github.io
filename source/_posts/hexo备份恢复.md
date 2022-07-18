---
title: hexo备份恢复
date: 2020-04-11 08:23:37
tags:
- hexo
categories:
- hexo
---

hexo 备份如何恢复

<!--more-->

### 下载仓库

从git上下载仓库，并切换分支

### 安装模块

```
# 先安装npm
yum install npm
# 查看版本
npm -v
node -v
```

下载完之后，[更换npm下载源](/2020/04/10/npm-更换源/)

```
# 安装modules, 速度非常慢, 可以先更换npm下载源
npm install
npm install -g hexo-cli
# 查看hexo是否安装成功
hexo -v
```

如果执行`hexo`命令显示异常，如下图：

![exception](exception.png)

那么需要更新nodejs

```
# 更新npm
npm i -g npm@latest
# 更新nodejs
npm install -g n
n latest
n # 查看已安装的版本
node -v # 查看是否更新成功
```

### 部署git

主要是两个方面：
- 设置全局用户名和邮箱(用于`commit`)
- 生成密钥(用于`push`权限)

```
git config --global user.name "your name"
git config --global user.email "your email"
ssh-keygen -t rsa -C "1301862177@qq.com"
# 生成公钥之后，复制到github账户的ssh_and_GPG_keys
# 然后测试链接是否成功
ssh -T git@github.com
# 设置下面不用每次push时输入账号密码
git config --global credential.helper store
```

### 关于 hexo-server

因为是放在服务器上，所以希望执行 `hexo server` 之后，外网也可以预览。

修改 `node_modules/hexo-server/lib/server.js`

```
function formatAddress(ip, port, root) {
  // if (ip === '0.0.0.0') ip = 'localhost'; 把这一行注释掉

  return format('http://%s:%d%s', ip, port, root);
}
```

然后打开服务器 `4000` 端口, [服务器打开端口在这](/2020/04/11/linux开启端口/)

执行命令

```
hexo server -i 0.0.0.0
```

打开浏览器，打开控制台，看看缺少哪些js文件，就到`theme`的`_config.yml`中找github地址进行下载