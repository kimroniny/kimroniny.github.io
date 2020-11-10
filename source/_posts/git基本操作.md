---
title: git基本操作
date: 2019-12-01 10:07:46
categories:
- git
tags:
- git
---

关于git的基本指令和操作，方便查询
<!--more-->

## add时忽略某些文件

根目录添加```.gitignore```文件，逐行写入需要忽略的文件
```bash
touch .gitignore
```

## 配置本地用户名和邮箱

```bash
git config --local user.name ""
git config --local user.email ""
```

## 不用每次输入账号密码

```bash
git config --global credential.helper store
```

## 标签的基本操作

### 创建tag

创建 tag 是基于本地分支的 commit，而且与分支的推送是两回事，就是说分支已经推送到远程了，但是你的 tag 并没有，如果把 tag 推送到远程分支上，需要另外执行 tag 的推送命令。

```
git tag <tagName> //创建本地tag

git push origin <tagName> //推送到远程仓库

git push origin --tags // 一次性推送全部tag

// 以上是基于本地当前分支的最后的一个commit 创建的 tag ，但是如果不想以最后一个，只想以某一个特定的提交为tag ，也是可以的，只要你知道commit 的id。

git log --pretty=oneline //查看当前分支的提交历史 里面包含 commit id

git tag -a <tagName> <commitId>
```

### 查看tag

```bash
git show <tagName>
git tag 
git ls-remote --tags origin // 查看远程tag
```


### 删除tag

```bash
git tag -d <tagName>
git push origin :<tagName>
```


